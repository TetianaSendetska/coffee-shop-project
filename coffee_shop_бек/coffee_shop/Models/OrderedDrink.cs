using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class OrderedDrink
    {
        public int Id { get; set; }
        public int? OrderId { get; set; }
        public int? DrinkId { get; set; }
        public int Amount { get; set; }

        public virtual DrinkMenu Drink { get; set; }
        public virtual Order Order { get; set; }
    }
}
