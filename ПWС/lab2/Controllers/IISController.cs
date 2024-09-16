using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace RestServiceLab2.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class IISController : ControllerBase
    {
        private static Stack<int> stack = new Stack<int>();

        private int GetSessionResult()
        {
            var result = HttpContext.Session.GetInt32("result");
            return result.HasValue ? result.Value : 0;
        }

        private void SetSessionResult(int result)
        {
            HttpContext.Session.SetInt32("result", result);
        }

        [HttpGet]
        public IActionResult GetResult()
        {
            int result = GetSessionResult();
            return Ok(new { RESULT = stack.Count > 0 ? result + stack.Peek() : result });
        }

        [HttpPost]
        public IActionResult PostResult([FromQuery] int RESULT)
        {
            SetSessionResult(RESULT);
            return Ok(new { RESULT = RESULT });
        }

        [HttpPut]
        public IActionResult PushToStack([FromQuery] int ADD)
        {
            stack.Push(ADD);
            return Ok(new { ADD = ADD });
        }

        [HttpDelete]
        public IActionResult PopFromStack()
        {
            if (stack.Count > 0)
            {
                int topElement = stack.Pop();
                int result = GetSessionResult();
                return Ok(new { POP = topElement, RESULT = result });
            }
            return BadRequest("Стек пуст.");
        }
    }
}
