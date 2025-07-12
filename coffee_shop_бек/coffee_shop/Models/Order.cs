using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Order
    {
        public Order()
        {
            Deliveries = new HashSet<Delivery>();
            OrderedDrinks = new HashSet<OrderedDrink>();
            OrderedFoods = new HashSet<OrderedFood>();
        }

        public int Id { get; set; }
        public DateTime? AcceptanceTime { get; set; }
        public int? TableId { get; set; }
        public sbyte? Takeout { get; set; }
        public int? UserId { get; set; }
        public string Status { get; set; }

        public virtual Employee Employee { get; set; }
        public virtual Table Table { get; set; }
        public virtual ICollection<Delivery> Deliveries { get; set; }
        public virtual ICollection<OrderedDrink> OrderedDrinks { get; set; }
        public virtual ICollection<OrderedFood> OrderedFoods { get; set; }
    }
}
