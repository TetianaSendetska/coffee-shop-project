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
    public class ClientController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public ClientController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Client>> GetCart()
            => await _coffee_ShopContext.Clients.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Client), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var clients = await _coffee_ShopContext.Clients.FindAsync(id);
            return clients == null ? NotFound() : Ok(clients);
        }

       

        [HttpGet("username")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Client), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetByUsernameAndPassword(string username, string password)
        {
            var client = _coffee_ShopContext.Clients.FirstOrDefault(o => o.Username == username && o.Password == PasswordHasher.HashPassword(password));

            return client == null ? NotFound() : Ok(client);
        }
        

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddClient(Client client)
        {
          
            if (string.IsNullOrEmpty(client.Password) || client.Password.Length < 6)
            {
                return BadRequest("Пароль має бути мінімум 6 символів");
            }
            client.Password = PasswordHasher.HashPassword(client.Password);
            try
            {
                var user = new Users
                {
                    Username = client.Username,
                    Password = client.Password,
                    Role = 2 // Припускаючи, що роль клієнта має назву 'Client'
                };
                await _coffee_ShopContext.Users.AddAsync(user);
                await _coffee_ShopContext.SaveChangesAsync();

                await _coffee_ShopContext.Clients.AddAsync(client);
                await _coffee_ShopContext.SaveChangesAsync();
               

                return CreatedAtAction(nameof(GetById), new
                {
                    name = client.Name,
                    email = client.Email,
                    phone = client.Phone,
                    username = client.Username,

                }, client);
            }
            catch (Exception ex)
            {
               
                return StatusCode(StatusCodes.Status500InternalServerError, $"Помилка під час збереження даних: {ex.Message}");
            }
        }

        [HttpGet("sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Client), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedData()
        {
            var sortedData = _coffee_ShopContext.Clients.OrderBy(f => f.Name).ToList();
            return Ok(sortedData);
        }


        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> UpdateClient(int id, Client client)
        {
            var existingClient = await _coffee_ShopContext.Clients.FindAsync(id);

            if (existingClient == null)
            {
                return BadRequest();
            }

            existingClient.Name = client.Name ?? existingClient.Name;
            existingClient.Phone = client.Phone ?? existingClient.Phone;
            existingClient.Email = client.Email ?? existingClient.Email;

            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteEmployee(int id)
        {
            var userToDelete = await _coffee_ShopContext.Users.FindAsync(id);

            var clientToDelete = await _coffee_ShopContext.Clients.FindAsync(id);
            if (clientToDelete == null) return NotFound();
            _coffee_ShopContext.Clients.Remove(clientToDelete);
            await _coffee_ShopContext.SaveChangesAsync();
            return NoContent();
        }


        [HttpDelete("delete/username")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteClient(string username)
        {
            var clientToDelete = _coffee_ShopContext.Clients.FirstOrDefault(o => o.Username == username);

            //return Ok(clientToDelete);
            if (clientToDelete == null) return NotFound();
            _coffee_ShopContext.Clients.Remove(clientToDelete);
            await _coffee_ShopContext.SaveChangesAsync();
            return NoContent();
        }
        /*
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddRegisterClient(Client client)
        {
            object p = await _coffee_ShopContext.Clients.AddAsync(client);
            await _coffee_ShopContext.SaveChangesAsync();

            return Ok(client);
        }*/

    }
}
