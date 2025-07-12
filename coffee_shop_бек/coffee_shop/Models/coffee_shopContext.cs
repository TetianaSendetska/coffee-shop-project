using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace coffee_shop.Models
{
    public partial class coffee_shopContext : DbContext
    {
        public coffee_shopContext()
        {
        }

        public coffee_shopContext(DbContextOptions<coffee_shopContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Cart> Cart { get; set; }
        public virtual DbSet<Client> Clients { get; set; }
        public virtual DbSet<Delivery> Delivery { get; set; }
        public virtual DbSet<DrinkMenu> DrinkMenu { get; set; }
        public virtual DbSet<Employee> Employees { get; set; }
        public virtual DbSet<FoodMenu> FoodMenu { get; set; }
        public virtual DbSet<Order> Order { get; set; }
        public virtual DbSet<OrderedDrink> OrderedDrink { get; set; }
        public virtual DbSet<OrderedFood> OrderedFood { get; set; }
        public virtual DbSet<Reservation> Reservation { get; set; }
        public virtual DbSet<SalesReport> SalesReport { get; set; }
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("##########", Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.35-mysql"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasCharSet("utf8mb4")
                .UseCollation("utf8mb4_0900_ai_ci");

            modelBuilder.Entity<Cart>(entity =>
            {
                entity.ToTable("cart");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.DrinkId).HasColumnName("drink_id");

                entity.Property(e => e.FoodId).HasColumnName("food_id");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.Property(e => e.UserId).HasColumnName("user_id");
            });

            modelBuilder.Entity<Client>(entity =>
            {
                entity.ToTable("clients");

                entity.HasIndex(e => e.Email, "unique_email")
                    .IsUnique();

                entity.HasIndex(e => e.Username, "username_UNIQUE")
                    .IsUnique();

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("created_date");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.Name)
                    .HasMaxLength(45)
                    .HasColumnName("name");

                entity.Property(e => e.Password)
                    .HasMaxLength(50)
                    .HasColumnName("password");

                entity.Property(e => e.Phone)
                    .HasMaxLength(20)
                    .HasColumnName("phone");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .HasColumnName("username");
            });

            modelBuilder.Entity<Delivery>(entity =>
            {
                entity.ToTable("delivery");

                entity.HasIndex(e => e.ClientId, "delivery_client_id_idx");

                entity.HasIndex(e => e.OrderId, "delivery_order_id_idx");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.AcceptanceTime)
                    .HasColumnType("datetime")
                    .HasColumnName("acceptance_time");

                entity.Property(e => e.Adress)
                    .HasMaxLength(45)
                    .HasColumnName("adress");

                entity.Property(e => e.ClientId).HasColumnName("client_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.Property(e => e.SendingTime)
                    .HasColumnType("datetime")
                    .HasColumnName("sending_time");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.Deliveries)
                    .HasForeignKey(d => d.ClientId)
                    .HasConstraintName("delivery_client_id");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.Deliveries)
                    .HasForeignKey(d => d.OrderId)
                    .HasConstraintName("delivery_order_id");
            });

            modelBuilder.Entity<DrinkMenu>(entity =>
            {
                entity.ToTable("drink_menu");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Ml).HasColumnName("ml");

                entity.Property(e => e.Name)
                    .HasMaxLength(45)
                    .HasColumnName("name");

                entity.Property(e => e.Price)
                    .HasPrecision(5, 2)
                    .HasColumnName("price");

                entity.Property(e => e.Status)
                    .HasMaxLength(45)
                    .HasColumnName("status");

                entity.Property(e => e.Type)
                    .HasMaxLength(45)
                    .HasColumnName("type");
            });

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.ToTable("employees");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Birthday)
                    .HasColumnType("date")
                    .HasColumnName("birthday");

                entity.Property(e => e.Name)
                    .HasMaxLength(45)
                    .HasColumnName("name");

                entity.Property(e => e.Position)
                    .HasMaxLength(45)
                    .HasColumnName("position");

                entity.Property(e => e.Salary)
                    .HasPrecision(7, 2)
                    .HasColumnName("salary");
            });

            modelBuilder.Entity<FoodMenu>(entity =>
            {
                entity.ToTable("food_menu");

                entity.HasIndex(e => e.Status, "idx_status_food");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Name)
                    .HasMaxLength(45)
                    .HasColumnName("name");

                entity.Property(e => e.Price)
                    .HasPrecision(5, 2)
                    .HasColumnName("price");

                entity.Property(e => e.Status)
                    .HasMaxLength(45)
                    .HasColumnName("status");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("order");

                entity.HasIndex(e => e.UserId, "order_employee_id_idx");

                entity.HasIndex(e => e.TableId, "order_table_id_idx");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.AcceptanceTime)
                    .HasColumnType("datetime")
                    .HasColumnName("acceptance_time");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .HasColumnName("status");

                entity.Property(e => e.TableId).HasColumnName("table_id");

                entity.Property(e => e.Takeout).HasColumnName("takeout");

                entity.HasOne(d => d.Employee)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("order_employee_id");

                entity.HasOne(d => d.Table)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.TableId)
                    .HasConstraintName("order_table_id");
            });

            modelBuilder.Entity<OrderedDrink>(entity =>
            {
                entity.ToTable("ordered_drinks");

                entity.HasIndex(e => e.DrinkId, "ordered_drinks_drink_id_idx");

                entity.HasIndex(e => e.OrderId, "ordered_drinks_order_id_idx");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Amount).HasColumnName("amount");

                entity.Property(e => e.DrinkId).HasColumnName("drink_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.HasOne(d => d.Drink)
                    .WithMany(p => p.OrderedDrinks)
                    .HasForeignKey(d => d.DrinkId)
                    .HasConstraintName("ordered_drinks_drink_id");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderedDrinks)
                    .HasForeignKey(d => d.OrderId)
                    .HasConstraintName("ordered_drinks_order_id");
            });

            modelBuilder.Entity<OrderedFood>(entity =>
            {
                entity.ToTable("ordered_food");

                entity.HasIndex(e => e.FoodId, "ordered_food_food_id_idx");

                entity.HasIndex(e => e.OrderId, "ordered_food_order_id_idx");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Amount).HasColumnName("amount");

                entity.Property(e => e.FoodId).HasColumnName("food_id");

                entity.Property(e => e.OrderId).HasColumnName("order_id");

                entity.HasOne(d => d.Food)
                    .WithMany(p => p.OrderedFoods)
                    .HasForeignKey(d => d.FoodId)
                    .HasConstraintName("ordered_food_food_id");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderedFoods)
                    .HasForeignKey(d => d.OrderId)
                    .HasConstraintName("ordered_food_order_id");
            });

            modelBuilder.Entity<Reservation>(entity =>
            {
                entity.ToTable("reservation");

                entity.HasIndex(e => e.ClientId, "reservation_client_id_idx");

                entity.HasIndex(e => e.TableId, "reservation_table_id_idx");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.ClientId).HasColumnName("client_id");

                entity.Property(e => e.ReservationTime)
                    .HasColumnType("datetime")
                    .HasColumnName("reservation_time");

                entity.Property(e => e.TableId).HasColumnName("table_id");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.ClientId)
                    .HasConstraintName("reservation_client_id");

                entity.HasOne(d => d.Table)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.TableId)
                    .HasConstraintName("reservation_table_id");
            });

            modelBuilder.Entity<SalesReport>(entity =>
            {
                entity.ToTable("sales_report");

 

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.AmountOfSales)
                    .HasPrecision(8, 2)
                    .HasColumnName("amount_of_sales");

                entity.Property(e => e.Datetime)
                    .HasColumnType("datetime")
                    .HasColumnName("datetime");

               
            });

            modelBuilder.Entity<Table>(entity =>
            {
                entity.ToTable("tables");

                entity.Property(e => e.Id)
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.NumberOfSeats).HasColumnName("number_of_seats");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
