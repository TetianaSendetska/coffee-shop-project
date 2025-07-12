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
    public class OrderController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public OrderController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Order>> GetOrder()
            => await _coffee_ShopContext.Order.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Order), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var order= await _coffee_ShopContext.Order.FindAsync(id);
            return order == null ? NotFound() : Ok(order);
        }

        [HttpGet("userId/status")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Order), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByIdAndStatus(int userId, string status)
        {
            var order = await _coffee_ShopContext.Order.Where(f => f.UserId == userId && f.Status == status).ToListAsync();
            return order == null ? NotFound() : Ok(order);
        }

        [HttpGet("status")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Order), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByStatus(string status)
        {
            var order = await _coffee_ShopContext.Order.Where(f => f.Status == status).ToListAsync();
            return order == null ? NotFound() : Ok(order);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddOrder(Order order)
        {
            object p = await _coffee_ShopContext.Order.AddAsync(order);
            await _coffee_ShopContext.SaveChangesAsync();

            return Ok(new { acceptanceTime = order.AcceptanceTime });
        }

        [HttpGet("acceptanceTime")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(IEnumerable<Order>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetOrdersByTime(DateTime acceptanceTime)
        {
            var orders = await _coffee_ShopContext.Order
                .Where(o => o.AcceptanceTime == acceptanceTime)
                .ToListAsync();

            return Ok(orders);  
        }


        [HttpGet("userId")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(IEnumerable<Order>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetOrdersByUserId(int userId)
        {
            var userOrders = await _coffee_ShopContext.Order
                .Where(o => o.UserId == userId)
                .ToListAsync();

            return Ok(userOrders);
        }

        [HttpPut("{orderId}")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> UpdateOrderStatus(int orderId, string newStatus)
        {
            var order = await _coffee_ShopContext.Order.FindAsync(orderId);

            if (order == null)
            {
                return NotFound();
            }

            order.Status = newStatus;
            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("datetime")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(SalesReport), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByDatetime(DateTime dateTime, int userId)
        {
            dateTime = dateTime.Date;
            var order = await _coffee_ShopContext.Order
                .Where(o => o.AcceptanceTime.Value.Date == dateTime && o.UserId == userId)
                .ToListAsync();

            return order == null ? NotFound() : Ok(order);
        }

    }
}
