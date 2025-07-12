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
    public class OrderedFoodController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public OrderedFoodController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<OrderedFood>> GetCart()
            => await _coffee_ShopContext.OrderedFood.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(OrderedFood), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var orderedFood = await _coffee_ShopContext.OrderedFood.FindAsync(id);
            return orderedFood == null ? NotFound() : Ok(orderedFood);
        }

        [HttpGet("orderId")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(OrderedFood), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByOrderId(int orderId)
        {
            var orderedFood =  _coffee_ShopContext.OrderedFood.Where(o => o.OrderId == orderId)
                .Select(d => new { d.FoodId, d.Amount })
                .ToList();
            return orderedFood == null ? NotFound() : Ok(orderedFood);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddOrderedFood(OrderedFood orderedFood)
        {
            object p = await _coffee_ShopContext.OrderedFood.AddAsync(orderedFood);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new
            {
                orderId = orderedFood.OrderId,
                foodId = orderedFood.FoodId,
                amount = orderedFood.Amount
            }, orderedFood);
        }
    }
}
