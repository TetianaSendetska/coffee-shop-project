using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Employee
    {
        public Employee()
        {
            Orders = new HashSet<Order>();
            SalesReports = new HashSet<SalesReport>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? Birthday { get; set; }
        public string Position { get; set; }
        public decimal? Salary { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<SalesReport> SalesReports { get; set; }
    }
}
