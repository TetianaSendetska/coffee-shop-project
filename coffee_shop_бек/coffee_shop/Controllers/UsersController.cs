using coffee_shop.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace coffee_shop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public UsersController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Users>> GetUser()
        {
            return await _coffee_ShopContext.Users.ToListAsync();
        }


        [HttpGet("username")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Users), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetByUsernameAndPassword(string username, string password)
        {
            var user = _coffee_ShopContext.Users.FirstOrDefault(o => o.Username == username && o.Password == PasswordHasher.HashPassword(password));

            if(user == null)
            {
                return NotFound();
            }
            else if(user.Role == 1)
            {
                return Ok(new { User = user, Client = (object)null });
            }
            else if(user.Role == 2)
            {
                var client = _coffee_ShopContext.Clients.FirstOrDefault(o => o.Username == username);
                return Ok(new { User = user, Client = client });
            }
            return StatusCode(500);
        }


        [HttpDelete("delete/username")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteUser(string username)
        {
            var userToDelete =  _coffee_ShopContext.Users.FirstOrDefault( o => o.Username == username);

 
            if (userToDelete == null) return NotFound();
            _coffee_ShopContext.Users.Remove(userToDelete);
            await _coffee_ShopContext.SaveChangesAsync();
            return NoContent();
        }
    }
}
