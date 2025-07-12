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
    public class OrderedDrinksController : ControllerBase
    {
        
        private readonly coffee_shopContext _coffee_ShopContext;

        public OrderedDrinksController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<OrderedDrink>> GetCart()
            => await _coffee_ShopContext.OrderedDrink.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(OrderedDrink), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var orderedDrinks = await _coffee_ShopContext.OrderedDrink.FindAsync(id);
            return orderedDrinks == null ? NotFound() : Ok(orderedDrinks);
        }

        [HttpGet("orderId")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(OrderedDrink), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetByOrderId(int orderId)
        {
            var orderedDrink = _coffee_ShopContext.OrderedDrink.Where(o => o.OrderId == orderId)
                .Select(d => new { d.DrinkId, d.Amount })
                .ToList();
            return orderedDrink == null ? NotFound() : Ok(orderedDrink);
        }
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddOrderedDrink(OrderedDrink orderedDrink)
        {
            object p = await _coffee_ShopContext.OrderedDrink.AddAsync(orderedDrink);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new
            {       
                orderId = orderedDrink.OrderId,
                drinkId = orderedDrink.DrinkId,
                amount = orderedDrink.Amount
            }, orderedDrink);
        }
    }
}
