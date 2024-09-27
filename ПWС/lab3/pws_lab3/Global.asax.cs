using System.Web;
using System;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace pws_lab3
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            GlobalConfiguration.Configure(RouteConfig.RegisterHttpRoutes);
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            var exception = Server.GetLastError();
            Response.Clear();

            var httpException = exception as HttpException;
            var statusCode = httpException != null ? httpException.GetHttpCode() : 500;

            Response.ContentType = "text/html"; // ������������� ��� �������� �� HTML
            Response.StatusCode = statusCode;

            // ������� HTML-�������� � ���������� �� ������
            var errorPage = $@"
    <!DOCTYPE html>
    <html lang='ru'>
    <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>������ {statusCode}</title>
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
            <h1>������ {statusCode}</h1>
            <p>{(statusCode == 404 ? "�������� �� �������." : "���������� ������ �������.")}</p>
        </div>
    </body>
    </html>";

            Response.Write(errorPage);
            Response.End();
        }


        protected void Application_BeginRequest()
        {
            var path = Request.Url.AbsolutePath;

            // ��������, ���������� �� �������
            var routeData = RouteTable.Routes.GetRouteData(new HttpContextWrapper(HttpContext.Current));
            if (routeData == null)
            {
                // ���� ������� �� ������, ���������� 404 ������
                Response.StatusCode = 404;
                Response.ContentType = "text/html"; // ������������� ��� �������� �� HTML

                // ������� HTML-�������� � ���������� �� ������
                var errorPage = @"
        <!DOCTYPE html>
        <html lang='ru'>
        <head>
            <meta charset='UTF-8'>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'>
            <title>������ 404</title>
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
                <h1>������ 404</h1>
                <p>�������� �� �������.</p>
            </div>
        </body>
        </html>";

                Response.Write(errorPage);
                Response.End();
            }
        }


    }
}
