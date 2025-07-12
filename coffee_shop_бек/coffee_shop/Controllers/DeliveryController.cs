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
    public class DeliveryController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public DeliveryController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Delivery>> GetCart()
            => await _coffee_ShopContext.Delivery.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Delivery), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var delivery = await _coffee_ShopContext.Delivery.FindAsync(id);
            return delivery == null ? NotFound() : Ok(delivery);
        }

        [HttpGet("orderId")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Delivery), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetByOrderId(int orderId)
        {
            var delivery = _coffee_ShopContext.Delivery.Where(o => o.OrderId == orderId)
                .Select(d => new { d.Adress, d.SendingTime})
                .ToList();
            return delivery == null ? NotFound() : Ok(delivery);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddDelivery(Delivery delivery)
        {
            await _coffee_ShopContext.Delivery.AddAsync(delivery);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new
            {
                adress = delivery.Adress,
                acceptanceTime = delivery.AcceptanceTime,
                orderId = delivery.OrderId,
                clientId = delivery.ClientId,
               
            }, delivery); 
        }
    }
}
