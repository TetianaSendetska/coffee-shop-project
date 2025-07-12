using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using coffee_shop.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.EntityFrameworkCore;

namespace coffee_shop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DrinkMenuController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public DrinkMenuController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }

        /*
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<DrinkMenu>> GetDrinkMenu()
            => await _coffee_ShopContext.DrinkMenu.ToListAsync();
        */

        [HttpGet]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetDrinkMenu()
        {
            var drinkMenu = await _coffee_ShopContext.DrinkMenu.Where(drink => drink.Status == "в наявності").ToListAsync();
            return drinkMenu.Count == 0 ? NotFound() : Ok(drinkMenu);
        }
        [HttpGet("price")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByPrice(double price)
        {
            var filteredByPrice = await _coffee_ShopContext.DrinkMenu.Where(food => food.Price.GetValueOrDefault() <= (decimal)price).ToListAsync();
            return filteredByPrice.Count == 0 ? NotFound() : Ok(filteredByPrice);
        }

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var drinkMenu = await _coffee_ShopContext.DrinkMenu.FindAsync(id);
            return drinkMenu == null ? NotFound() : Ok(drinkMenu);
        }
        [HttpGet("sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedData()
        {
            var sortedData = _coffee_ShopContext.DrinkMenu.OrderBy(f => f.Name).Where(o => o.Status == "в наявності").ToList();
            return Ok(sortedData);
        }
        [HttpGet("type")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedByType(string type)
        {
            var sortedByTypeData = _coffee_ShopContext.DrinkMenu.Where(f => f.Type == type).ToList();
            return Ok(sortedByTypeData);
        }

        [HttpGet("all")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetAllDrinkMenu()
        {
            var drinkMenu = await _coffee_ShopContext.DrinkMenu.ToListAsync();
            return drinkMenu.Count == 0 ? NotFound() : Ok(drinkMenu);
        }

        [HttpGet("all/sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(DrinkMenu), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedAllData()
        {
            var sortedData = _coffee_ShopContext.DrinkMenu.OrderBy(f => f.Name).ToList();
            return Ok(sortedData);
        }

        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> UpdateStatusMenu(int id, string status)
        {
            var existingMenuItem = await _coffee_ShopContext.DrinkMenu.FindAsync(id);

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
