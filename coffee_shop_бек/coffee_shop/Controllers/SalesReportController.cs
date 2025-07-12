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
    public class SalesReportController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public SalesReportController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<SalesReport>> GetCart()
        {
            var reports = await _coffee_ShopContext.SalesReport
                .Select(o => new SalesReport { Id = o.Id, Datetime = o.Datetime, AmountOfSales = o.AmountOfSales })
                .ToListAsync();

            return reports.OrderBy(sr => sr.Datetime);
        }

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(SalesReport), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var clients = await _coffee_ShopContext.SalesReport.FindAsync(id);
            return clients == null ? NotFound() : Ok(clients);
        }



        [HttpGet("datetime")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(SalesReport), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetByDatetime(DateTime dateTime)
        {
            var report = await _coffee_ShopContext.SalesReport
                .Where(o => o.Datetime == dateTime)
                .Select(o => new { o.Id, o.Datetime, o.AmountOfSales })
                .ToListAsync();

            return report == null ? NotFound() : Ok(report);
        }

        /* [HttpGet("order_count")]
         [EnableCors("AllowOrigin")]
         [ProducesResponseType(typeof(FoodMenu), StatusCodes.Status200OK)]
         [ProducesResponseType(StatusCodes.Status404NotFound)]
         public async Task<IActionResult> GetOrdersByDate(DateTime dateTime)
         {


             var result = await _coffee_ShopContext.Database
                      .FrowSqlRaw("CALL CountOrdersByDay({0})", dateTime).ToListAsync();


             // Тепер в `ordersByDay` у вас будуть тільки дані, які відповідають часу `dateTime`.

             return Ok(result);
         }*/

        [HttpGet("order_count")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(List<object>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetOrderCountByDay(DateTime dateTime)
        {
            var orderCounts = await _coffee_ShopContext.Order
                .Where(o => o.AcceptanceTime.Value.Date == dateTime.Date)
                .GroupBy(o => o.AcceptanceTime.Value.Date)
                .Select(g => new
                {
                    Date = g.Key,
                    OrderCount = g.Count()
                })
                .ToListAsync();

            return orderCounts == null ? NotFound() : Ok(orderCounts);
        }

        [HttpGet("drink_count")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetDrinkCountByDay(DateTime dateTime)
        {
            var orderIds = await _coffee_ShopContext.Order
                .Where(o => o.AcceptanceTime.Value.Date == dateTime.Date)
                .Select(o => o.Id)
                .ToListAsync();

            int amountOfDrinks = 0;

            foreach (int id in orderIds)
            {
                var amount = await _coffee_ShopContext.OrderedDrink
                    .Where(a => a.OrderId == id)
                    .Select(s => s.Amount)
                    .SumAsync(); // Використовуйте метод SumAsync() для підрахунку суми
                amountOfDrinks += amount;
            }
            return Ok(amountOfDrinks);
        }

        [HttpGet("food_count")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetFoodCountByDay(DateTime dateTime)
        {
            var orderIds = await _coffee_ShopContext.Order
                .Where(o => o.AcceptanceTime.Value.Date == dateTime.Date)
                .Select(o => o.Id)
                .ToListAsync();

            int amountOfFood = 0;

            foreach (int id in orderIds)
            {
                var amount = await _coffee_ShopContext.OrderedFood
                    .Where(a => a.OrderId == id)
                    .Select(s => s.Amount)
                    .SumAsync(); // Використовуйте метод SumAsync() для підрахунку суми
                amountOfFood += amount;
            }
            return Ok(amountOfFood);
        }

        [HttpGet("client_count")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetClientsCount()
        {
            int clientsCount = await _coffee_ShopContext.Clients.CountAsync();
            return Ok(clientsCount);
        }

        [HttpGet("employee_count")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(int), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetEmployeeCount()
        {
            int employeeCount = await _coffee_ShopContext.Employees.CountAsync();
            return Ok(employeeCount);
        }

    }
}
