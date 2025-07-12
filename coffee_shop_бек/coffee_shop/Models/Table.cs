using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Table
    {
        public Table()
        {
            Orders = new HashSet<Order>();
            Reservations = new HashSet<Reservation>();
        }

        public int Id { get; set; }
        public int? NumberOfSeats { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
    }
}
