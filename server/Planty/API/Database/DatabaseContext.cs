using API.Entities;
using Microsoft.EntityFrameworkCore;

namespace API.Database {
    public class DatabaseContext : DbContext{

        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {

            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Sensor>().HasData(
                new Sensor { Port = "A0" },
                new Sensor { Port = "A3" },
                new Sensor { Port = "A4" },
                new Sensor { Port = "A5" }
                );
        }


        public virtual DbSet<Plant> Plants { get; set; }
        public virtual DbSet<PlantReading> PlantsReadings { get; set;}
        public virtual DbSet<Sensor> Sensors { get; set; }
        public virtual DbSet<WaterReading> WaterReadings { get; set; }

    }
}
