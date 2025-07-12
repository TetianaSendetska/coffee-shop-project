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
    public class EmployeesController : ControllerBase
    {
        private readonly coffee_shopContext _coffee_ShopContext;

        public EmployeesController(coffee_shopContext coffee_ShopContext)
        {
            _coffee_ShopContext = coffee_ShopContext;
        }
        [HttpGet]
        [EnableCors("AllowOrigin")]
        public async Task<IEnumerable<Employee>> GetEmployee()
            => await _coffee_ShopContext.Employees.ToListAsync();

        [HttpGet("id")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Employee), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var clients = await _coffee_ShopContext.Employees.FindAsync(id);
            return clients == null ? NotFound() : Ok(clients);
        }

        [HttpGet("sorted")]
        [EnableCors("AllowOrigin")]
        [ProducesResponseType(typeof(Employee), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetSortedData()
        {
            var sortedData = _coffee_ShopContext.Employees.OrderBy(f => f.Name).ToList();
            return Ok(sortedData);
        }

        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> UpdateEmployee(int id, Employee employee)
        {
            var existingEmployee = await _coffee_ShopContext.Employees.FindAsync(id);

            if (existingEmployee == null)
            {
                return BadRequest();
            }

            existingEmployee.Name = employee.Name ??  existingEmployee.Name;
            existingEmployee.Birthday = employee.Birthday ?? existingEmployee.Birthday;
            existingEmployee.Position = employee.Position ?? existingEmployee.Position;
            existingEmployee.Salary = employee.Salary ?? existingEmployee.Salary;

            await _coffee_ShopContext.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> DeleteEmployee(int id)
        {
            var employeeToDelete = await _coffee_ShopContext.Employees.FindAsync(id);

            //return Ok(clientToDelete);
            if (employeeToDelete == null) return NotFound();
            _coffee_ShopContext.Employees.Remove(employeeToDelete);
            await _coffee_ShopContext.SaveChangesAsync();
            return NoContent();
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [EnableCors("AllowOrigin")]
        public async Task<IActionResult> CreateEmployee(Employee employee)
        {
            await _coffee_ShopContext.Employees.AddAsync(employee);
            await _coffee_ShopContext.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = employee.Id }, employee);
        }
    }
}
