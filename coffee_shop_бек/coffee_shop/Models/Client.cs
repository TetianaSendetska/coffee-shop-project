using System;
using System.Collections.Generic;

#nullable disable

namespace coffee_shop.Models
{
    public partial class Client
    {
        public Client()
        {
            Deliveries = new HashSet<Delivery>();
            Reservations = new HashSet<Reservation>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public DateTime? CreatedDate { get; set; }

        public virtual ICollection<Delivery> Deliveries { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
    }
}
