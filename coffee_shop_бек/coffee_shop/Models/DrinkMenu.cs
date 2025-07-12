using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class DrinkMenu
    {
        public DrinkMenu()
        {
            OrderedDrinks = new HashSet<OrderedDrink>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
        public string Status { get; set; }
        public string Type { get; set; }
        public int? Ml { get; set; }

        public virtual ICollection<OrderedDrink> OrderedDrinks { get; set; }
    }
}
