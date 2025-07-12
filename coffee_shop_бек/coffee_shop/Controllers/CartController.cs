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
    public class CartController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public CartController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Cart>> GetCart()
            => await _coffee_ShopContext.Cart.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Cart), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var cart = await _coffee_ShopContext.Cart.FindAsync(id);
            return cart == null ? NotFound() : Ok(cart);
        }
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddToCart(Cart cart)
        {
            await _coffee_ShopContext.Cart.AddAsync(cart);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new
            {
                drinkId = cart.DrinkId,
                foodId = cart.FoodId,
                quantity = cart.Quantity,
                userId = cart.UserId,
                name = cart.Name,
                price = cart.Price
            }, cart); ;
        }

        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> UpdateCartItem(int id, Cart cartItem)
        {
            var existingCartItem = await _coffee_ShopContext.Cart.FindAsync(id);

            if (existingCartItem == null)
            {
                return BadRequest();
            }

            existingCartItem.Quantity = cartItem.Quantity;
            // Оновлюємо інші поля за необхідності

            _coffee_ShopContext.Entry(existingCartItem).State = EntityState.Modified;
            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{userId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteCart(int userId)
        {
            var cartToDelete =  _coffee_ShopContext.Cart.Where(f => f.UserId == userId);
            if (cartToDelete == null) return NotFound();
            _coffee_ShopContext.Cart.RemoveRange(cartToDelete);
            await _coffee_ShopContext.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("item/{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteFromCart(int id)
        {
            var cartToDelete = await _coffee_ShopContext.Cart.FindAsync(id);
            if (cartToDelete == null) return NotFound();

            _coffee_ShopContext.Cart.Remove(cartToDelete);
            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }


    }
}
