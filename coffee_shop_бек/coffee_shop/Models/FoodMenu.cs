using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class FoodMenu
    {
        public FoodMenu()
        {
            OrderedFoods = new HashSet<OrderedFood>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
        public string Status { get; set; }

        public virtual ICollection<OrderedFood> OrderedFoods { get; set; }
    }
}
