using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class SalesReport
    {
        public int Id { get; set; }
        public DateTime? Datetime { get; set; }
        public decimal? AmountOfSales { get; set; }
      
    }
}
