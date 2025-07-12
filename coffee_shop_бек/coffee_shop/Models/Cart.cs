using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Cart
    {
        public int Id { get; set; }
        public int? DrinkId { get; set; }
        public int? FoodId { get; set; }
        public int? Quantity { get; set; }
        public int? UserId { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }

    }
}
