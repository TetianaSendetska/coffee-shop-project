using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Reservation
    {
        public int Id { get; set; }
        public int? TableId { get; set; }
        public DateTime? ReservationTime { get; set; }
        public int? ClientId { get; set; }

        public virtual Client Client { get; set; }
        public virtual Table Table { get; set; }
    }
}
