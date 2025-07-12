using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class OrderedFood
    {
        public int Id { get; set; }
        public int? OrderId { get; set; }
        public int? FoodId { get; set; }
        public int Amount { get; set; }

        public virtual FoodMenu Food { get; set; }
        public virtual Order Order { get; set; }
    }
}
