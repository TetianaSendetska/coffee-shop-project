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
    public class ReservationController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public ReservationController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Reservation>> GetCart()
            => await _coffee_ShopContext.Reservation.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Reservation), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var reservation = await _coffee_ShopContext.Reservation.FindAsync(id);
            return reservation == null ? NotFound() : Ok(reservation);
        }
       
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> AddReservation(Reservation reservation)
        {
            await _coffee_ShopContext.Reservation.AddAsync(reservation);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new
            {
                tableId = reservation.TableId,
                reservationTime = reservation.ReservationTime,
                clientId = reservation.ClientId,
            }, reservation) ; ;
        }

    }
}
