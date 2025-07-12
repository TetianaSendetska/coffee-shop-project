using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Delivery
    {
        public int Id { get; set; }
        public string Adress { get; set; }
        public DateTime? AcceptanceTime { get; set; }
        public int? OrderId { get; set; }
        public int? ClientId { get; set; }
        public DateTime? SendingTime { get; set; }

        public virtual Client Client { get; set; }
        public virtual Order Order { get; set; }
    }
}
