using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using coffee_shop.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace coffee_shop.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class FoodMenuController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public FoodMenuController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }


        /*[HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<FoodMenu>> GetFoodMenu()
            => await _coffee_ShopContext.FoodMenu.ToListAsync();
        */
        [HttpGet]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetFoodMenu()
        {
            var foodMenu = await _coffee_ShopContext.FoodMenu.Where(drink => drink.Status == "в наявності").ToListAsync();
            return foodMenu.Count == 0 ? NotFound() : Ok(foodMenu);
        }

        [HttpGet("all")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetAllFoodMenu()
        {
            var foodMenu = await _coffee_ShopContext.FoodMenu.ToListAsync();
            return foodMenu.Count == 0 ? NotFound() : Ok(foodMenu);
        }

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var foodMenu = await _coffee_ShopContext.FoodMenu.FindAsync(id);
            return foodMenu == null ? NotFound() : Ok(foodMenu);
        }

        
        [HttpGet("price")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByPrice(double price)
        {
            var filteredByPrice = await _coffee_ShopContext.FoodMenu.Where(food => food.Price.GetValueOrDefault() <= (decimal)price).ToListAsync();
            return filteredByPrice.Count == 0 ? NotFound() : Ok(filteredByPrice);
        }

        [HttpGet("all/sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedAllData()
        {
            var sortedData = _coffee_ShopContext.FoodMenu.OrderBy(f => f.Name).ToList();
            return Ok(sortedData);
        }

        [HttpGet("sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedData()
        {
            var sortedData = _coffee_ShopContext.FoodMenu.OrderBy(f => f.Name).Where(o=>o.Status == "в наявності").ToList();
            return Ok(sortedData);
        }

        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> UpdateStatusMenu(int id, string status)
        {
            var existingMenuItem = await _coffee_ShopContext.FoodMenu.FindAsync(id);

            if (existingMenuItem == null)
            {
                return BadRequest();
            }

            existingMenuItem.Status = status;
            // Оновлюємо інші поля за необхідності

            _coffee_ShopContext.Entry(existingMenuItem).State = EntityState.Modified;
            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }



    }
}
