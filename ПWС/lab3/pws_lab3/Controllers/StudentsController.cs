using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using PWS_3.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Results;
using System.Xml;
using System.Xml.Linq;

namespace PWS_3.Controllers
{
    public class StudentsController : ApiController
    {
        DB_Context context = new DB_Context();

        [HttpGet]
        [Route("api/Students.{format?}")]
        public object Get(HttpRequestMessage request, string format = "json")
        {
            Uri uri = request.RequestUri;
            try
            {
                var query = HttpUtility.ParseQueryString(uri.Query);

                string sort = query["sort"];
                int ParseInt(string key, int defaultValue = 0) => Int32.TryParse(query[key], out var value) ? value : defaultValue;

                // Получаем лимит и номер страницы
                int limit = ParseInt("limit", 10);  // Количество записей на странице
                int page = ParseInt("page", 1);     // Текущая страница
                int offset = ParseInt("offset");     // Смещение для базы данных (остается без изменений)

                // Вычисляем общее смещение на основе номера страницы и смещения
                int pageOffset = (page - 1) * limit; // Смещение для получения студентов по номеру страницы
                int totalOffset = pageOffset + offset; // Общее смещение, учитывающее как page, так и offset

                int minid = ParseInt("minid");
                int maxid = ParseInt("maxid", 1000);

                string columns = query["columns"];
                string globallike = query["globallike"];
                string like = query["like"];

                // Получаем список студентов с учетом лимита и общего смещения
                List<Student> students = context.GetList(limit, sort, totalOffset, minid, maxid, like, globallike);

                // Проверка, какие колонки клиент хочет получить (id, name, number)
                bool isId = !string.IsNullOrEmpty(columns) && columns.Contains("id");
                bool isName = !string.IsNullOrEmpty(columns) && columns.Contains("name");
                bool isNumber = !string.IsNullOrEmpty(columns) && columns.Contains("number");

                if (string.IsNullOrEmpty(columns))
                {
                    isId = true;
                    isName = true;
                    isNumber = true;
                }

                // Преобразуем студентов в DTO объекты для отправки
                List<StudentDto> result = new List<StudentDto>();
                foreach (Student student in students)
                {
                    StudentDto dto = new StudentDto(student);
                    dto.Links = new Link[]
                    {
                new Link($"/api/students/{student.Id}", "GET", "Получить информацию"),
                new Link($"/api/students/{student.Id}", "PUT", "Обновить информацию"),
                new Link($"/api/students/{student.Id}", "DELETE", "Удалить студента")
                    };
                    dto.IdSpecified = isId;
                    dto.NameSpecified = isName;
                    dto.NumberSpecified = isNumber;
                    result.Add(dto);
                }

                var links = new Link[]
                {
            new Link("/api/students/", "POST", "Добавить информацию"),
                };
                Models.Array array = new Models.Array(result, links);

                // Подсчитываем общее количество студентов для вычисления страниц
                int totalStudents = context.Students.Count();
                int totalPages = (int)Math.Ceiling(totalStudents / (double)limit);

                // Создаем массив страниц
                var pages = new List<object>();
                for (int i = 1; i <= totalPages; i++)
                {
                    pages.Add(new
                    {
                        page = i,
                        href = $"/api/Students.json?page={i}&limit={limit}",
                        method = "GET"
                    });
                }

                // Если запрашивается формат XML
                if (format == "xml")
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    XmlElement rootElement = xmlDoc.CreateElement("ArrayOfStudentDto");
                    xmlDoc.AppendChild(rootElement);

                    foreach (StudentDto dto in result)
                    {
                        XmlElement studentElement = xmlDoc.CreateElement("StudentDto");

                        if (isId) AddXmlElement(xmlDoc, studentElement, "Id", dto.Id.ToString());
                        if (isName) AddXmlElement(xmlDoc, studentElement, "Name", dto.Name);
                        if (isNumber) AddXmlElement(xmlDoc, studentElement, "Number", dto.Number);

                        // Добавляем ссылки
                        XmlElement linksElement = xmlDoc.CreateElement("Links");
                        foreach (var link in dto.Links)
                        {
                            XmlElement linkElement = xmlDoc.CreateElement("Link");
                            AddXmlElement(xmlDoc, linkElement, "Href", link.Href);
                            AddXmlElement(xmlDoc, linkElement, "Method", link.Method);
                            AddXmlElement(xmlDoc, linkElement, "Message", link.Message);
                            linksElement.AppendChild(linkElement);
                        }

                        studentElement.AppendChild(linksElement);
                        rootElement.AppendChild(studentElement);
                    }

                    XmlWriterSettings settings = new XmlWriterSettings
                    {
                        Indent = true,
                        IndentChars = "    ",
                        NewLineChars = "\n",
                        NewLineOnAttributes = false,
                        NewLineHandling = NewLineHandling.Replace
                    };

                    using (StringWriter stringWriter = new StringWriter())
                    {
                        using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter, settings))
                        {
                            xmlDoc.Save(xmlWriter);
                        }

                        HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK)
                        {
                            Content = new StringContent(stringWriter.ToString(), Encoding.UTF8, "application/xml")
                        };
                        return response;
                    }
                }
                // Если запрашивается формат JSON
                else if (format == "json" || format == null)
                {
                    // Возвращаем список студентов с текущей страницей и общим количеством страниц
                    return Json(new
                    {
                        students = array,
                        currentPage = page,
                        totalPages = totalPages,
                        pages // Добавляем массив страниц
                    });
                }
                else
                {
                    return HandleError(501, "Неверный формат");
                }
            }
            catch (Exception e)
            {
                // Создаем объект ошибки с детальной информацией
                var errorDetails = new ErrorDto
                {
                    Code = 500,
                    Message = e.Message, // Сообщение об ошибке
                };

                // Определяем формат ответа
                if (format == "xml")
                {
                    // Возвращаем ответ в формате XML
                    return Content(HttpStatusCode.BadRequest, errorDetails, Configuration.Formatters.XmlFormatter);
                }
                else if (format == "json" || format == null)
                {
                    // Возвращаем ответ в формате JSON
                    return Content(HttpStatusCode.BadRequest, errorDetails, Configuration.Formatters.JsonFormatter);
                }
                else
                {
                    // Обрабатываем неверный формат
                    return HandleError(501, "Неверный формат");
                }
            }
        }





        [HttpGet]
        [Route("api/Students.{format?}/{id}")]
        public object Get(int id, HttpRequestMessage request, string format = "json")
        {
            Uri uri = request.RequestUri;
            
            //string format = request.Content.Headers.ContentType?.MediaType;

            try
            {
                string columns = HttpUtility.ParseQueryString(uri.Query).Get("columns");
                bool isId = false, isName = false, isNumber = false;
                if (columns != "" && columns != null)
                {
                    isId = columns.Contains("id");
                    isName = columns.Contains("name");
                    isNumber = columns.Contains("number");
                }
                else
                {
                    isId = true;
                    isName = true;
                    isNumber = true;
                }

                Student student = context.GetOne(id);
                StudentDto dto = new StudentDto(student);

                dto.IdSpecified = isId;
                dto.NameSpecified = isName;
                dto.NumberSpecified = isNumber;

                Link[] links = new Link[]
                {
                    new Link("/api/students/" + id, "PUT", "Update"),
                    new Link("/api/students/" + id, "DELETE", "Delete")
                };
                dto.Links = links;

                XmlDocument xmlDoc = new XmlDocument();
                XmlElement rootElement = xmlDoc.CreateElement("StudentDto");
                xmlDoc.AppendChild(rootElement);

                if (isId) AddXmlElement(xmlDoc, rootElement, "Id", (dto.Id).ToString());
                if (isName) AddXmlElement(xmlDoc, rootElement, "Name", dto.Name);
                if (isNumber) AddXmlElement(xmlDoc, rootElement, "Number", dto.Number);

                XmlElement linksElement = xmlDoc.CreateElement("Links");
                foreach (var link in dto.Links)
                {
                    XmlElement linkElement = xmlDoc.CreateElement("Link");

                    AddXmlElement(xmlDoc, linkElement, "Href", link.Href);
                    AddXmlElement(xmlDoc, linkElement, "Method", link.Method);
                    AddXmlElement(xmlDoc, linkElement, "Message", link.Message);

                    linksElement.AppendChild(linkElement);
                }

                rootElement.AppendChild(linksElement);

                if (format == "xml")
                {
                    XmlWriterSettings settings = new XmlWriterSettings
                    {
                        Indent = true,        // Включить форматирование
                        IndentChars = "    ", // Установить символы отступа
                        NewLineChars = "\n",    // Установить символ новой строки
                        NewLineOnAttributes = false, // Новая строка только после тегов, а не после атрибутов
                        NewLineHandling = NewLineHandling.Replace // Замена новых строк
                    };

                    using (StringWriter stringWriter = new StringWriter())
                    {
                        using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter, settings))
                        {
                            xmlDoc.Save(xmlWriter);
                        }

                        HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
                        response.Content = new StringContent(stringWriter.ToString(), Encoding.UTF8, "application/xml");
                        return response;
                    }
                }
                else if (format == "json" || format == null) return Json(dto);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }
            catch (Exception e)
            {
                if (format == "xml") return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.JsonFormatter);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }
        }

        private void AddXmlElement(XmlDocument xmlDoc, XmlElement parentElement, string elementName, string value)
        {
            XmlElement element = xmlDoc.CreateElement(elementName);
            element.InnerText = value;
            parentElement.AppendChild(element);

        }

        [HttpPost]
        [Route("api/Students.{format?}")]
        public object Post(HttpRequestMessage request, string format = "json")
        {
            Uri uri = request.RequestUri;
            //string format = request.Content.Headers.ContentType?.MediaType;
            var body = request.Content;
            string json = body.ReadAsStringAsync().Result;
            dynamic data = JObject.Parse(json);
            if (data.name == null || data.number == null)
            {
                if (format == "xml") return Content(HttpStatusCode.BadRequest, new ErrorDto(400), Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Content(HttpStatusCode.BadRequest, new ErrorDto(400), Configuration.Formatters.JsonFormatter);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }

            try
            {
                string nam = Convert.ToString(data.name);
                string num = Convert.ToString(data.number);
                Student student = context.Post(nam, num);
                StudentDto dto = new StudentDto(student);

                Link[] links = new Link[]
                {
                    new Link("/api/students/" + student.Id, "GET", "Получить студента"),
                };
                dto.Links = links;

                if (format == "xml") return Content(HttpStatusCode.OK, dto, Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Json(dto);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);

            }
            catch (Exception e)
            {
                if (format == "xml") return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.JsonFormatter);
                else if (format == "json" || format == null) return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.JsonFormatter);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }
        }

        [HttpPut]
        [Route("api/Students.{format?}/{id}")]
        public object Put(int id, HttpRequestMessage request, string format = "json")
        {
            Uri uri = request.RequestUri;
            //string format = request.Content.Headers.ContentType?.MediaType;
            var body = request.Content;
            string json = body.ReadAsStringAsync().Result;
            dynamic data = JObject.Parse(json);
            string columns = HttpUtility.ParseQueryString(uri.Query).Get("columns");
            bool isId = false, isName = false, isNumber = false;
            if (columns != "" && columns != null)
            {
                isId = columns.Contains("id");
                isName = columns.Contains("name");
                isNumber = columns.Contains("number");
            }
            else
            {
                isId = true;
                isName = true;
                isNumber = true;
            }
            try
            {
                Student student = context.Put(id, Convert.ToString(data.name), Convert.ToString(data.number));
                StudentDto dto = new StudentDto(student);
                Link[] links = new Link[]
                {
                    new Link("/api/students/" + id, "GET", "Получить студента"),
                    new Link("/api/students/" + id, "DELETE", "Удалить студента")
                };
                dto.Links = links;

                XmlDocument xmlDoc = new XmlDocument();
                XmlElement rootElement = xmlDoc.CreateElement("StudentDto");
                xmlDoc.AppendChild(rootElement);

                if (isId) AddXmlElement(xmlDoc, rootElement, "Id", (dto.Id).ToString());
                if (isName) AddXmlElement(xmlDoc, rootElement, "Name", dto.Name);
                if (isNumber) AddXmlElement(xmlDoc, rootElement, "Number", dto.Number);

                XmlElement linksElement = xmlDoc.CreateElement("Links");
                foreach (var link in dto.Links)
                {
                    XmlElement linkElement = xmlDoc.CreateElement("Link");

                    AddXmlElement(xmlDoc, linkElement, "Href", link.Href);
                    AddXmlElement(xmlDoc, linkElement, "Method", link.Method);
                    AddXmlElement(xmlDoc, linkElement, "Message", link.Message);

                    linksElement.AppendChild(linkElement);
                }

                rootElement.AppendChild(linksElement);

                if (format == "xml")
                {
                    XmlWriterSettings settings = new XmlWriterSettings
                    {
                        Indent = true,        // Включить форматирование
                        IndentChars = "    ", // Установить символы отступа
                        NewLineChars = "\n",    // Установить символ новой строки
                        NewLineOnAttributes = false, // Новая строка только после тегов, а не после атрибутов
                        NewLineHandling = NewLineHandling.Replace // Замена новых строк
                    };

                    using (StringWriter stringWriter = new StringWriter())
                    {
                        using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter, settings))
                        {
                            xmlDoc.Save(xmlWriter);
                        }

                        HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
                        response.Content = new StringContent(stringWriter.ToString(), Encoding.UTF8, "application/xml");
                        return response;
                    }
                }
                else if (format == "json" || format == null) return Json(dto);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);

            }
            catch (Exception e)
            {
                if (format == "xml") return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.JsonFormatter);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);

            }

        }

        [HttpDelete]
        [Route("api/Students.{format?}/{id}")]
        public object Delete(int id, HttpRequestMessage request, string format = "json")
        {
            Uri uri = request.RequestUri;
            //string format = request.Content.Headers.ContentType?.MediaType;
            var body = request.Content;
            string json = body.ReadAsStringAsync().Result;
            dynamic data = JObject.Parse(json);
            try
            {
                Student student = context.Delete(id);
                StudentDto dto = new StudentDto(student);

                if (format == "xml") return Content(HttpStatusCode.OK, dto, Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Json(dto);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }
            catch (Exception e)
            {
                if (format == "xml") return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.XmlFormatter);
                else if (format == "json" || format == null) return Content(HttpStatusCode.BadRequest, new ErrorDto(500), Configuration.Formatters.JsonFormatter);
                else return Content(HttpStatusCode.BadRequest, new ErrorDto(501), Configuration.Formatters.JsonFormatter);
            }
        }

        [HttpGet]
        [Route("api/students/pages")]
        public object GetPageCount(int limit)
        {
            // Получаем общее количество записей
            int totalStudents = context.Students.Count();

            // Вычисляем количество страниц
            int pageCount = (int)Math.Ceiling(totalStudents / (double)limit);

            return Json(new { totalStudents, pageCount });
        }


        [HttpGet]
        [Route("api/ResourceInfo")]

        public string GetResourceInfo()
        {
            var resourceInfo = new
            {
                Methods = new[] { "GET", "POST" },
                UriFormat = "/api/students.{xml/json}",
                Method = new[] {"PUT", "DELETE"},
                Uri = "/api/students.{xml/json}/{studentNum}"
            };

            var jsonInfo = JsonConvert.SerializeObject(resourceInfo);

            return jsonInfo;
        }


        // Метод для обработки ошибок внутри текущего контроллера
        private IHttpActionResult HandleError(int statusCode, string message)
        {
            // В зависимости от типа запроса рендерим JSON или HTML страницу
            if (Request.Content.Headers.ContentType?.MediaType == "application/json")
            {
                return Json(new { code = statusCode, message = message ?? "Ошибка сервера" });
            }

            var errorPage = $@"
        <!DOCTYPE html>
        <html lang='ru'>
        <head>
            <meta charset='UTF-8'>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'>
            <title>Ошибка {statusCode}</title>
            <style>
                body {{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    font-family: Arial, sans-serif;
                    background-color: #f8f9fa;
                    text-align: center;
                }}
                .error-message {{
                    background: white;
                    padding: 20px;
                    border-radius: 5px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }}
            </style>
        </head>
        <body>
            <div class='error-message'>
                <h1>Ошибка {statusCode}</h1>
                <p>{message ?? "Произошла ошибка"}</p>
            </div>
        </body>
        </html>";

            return new ResponseMessageResult(new HttpResponseMessage
            {
                Content = new StringContent(errorPage, System.Text.Encoding.UTF8, "text/html"),
                StatusCode = (HttpStatusCode)statusCode
            });
        }
    }
}