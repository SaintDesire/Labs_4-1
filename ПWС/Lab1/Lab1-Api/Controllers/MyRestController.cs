using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace MyRestService.Controllers
{
    [ApiController]
    [Route("/")]
    public class MyRestController : ControllerBase
    {
        private static int RESULT = 0;
        private static Stack<int> stack = new Stack<int>();

        // GET
        [HttpGet]
        public IActionResult GetResult()
        {
            return Ok(new { RESULT });
        }

        // POST
        [HttpPost]
        public IActionResult PostResult([FromQuery] int result)
        {
            RESULT = result;
            return Ok(new { RESULT });
        }

        // PUT
        [HttpPut]
        public IActionResult PushToStack([FromQuery] int add)
        {
            stack.Push(add);
            return Ok(new { ADD = add });
        }

        // DELETE
        [HttpDelete]
        public IActionResult PopFromStack()
        {
            if (stack.Count > 0)
            {
                int poppedValue = stack.Pop();
                RESULT += poppedValue;
                return Ok(new { RESULT });
            }
            else
            {
                return BadRequest("Stack is empty.");
            }
        }
    }
}
