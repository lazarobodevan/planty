﻿// <auto-generated />
using System;
using API.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace API.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20250127220924_SeedSensors")]
    partial class SeedSensors
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.1")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("API.Entities.Plant", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text")
                        .HasColumnName("description");

                    b.Property<int>("IdealLightExposure")
                        .HasColumnType("integer")
                        .HasColumnName("ideal_light_exposure");

                    b.Property<int>("IdealMoisturePercentage")
                        .HasColumnType("integer")
                        .HasColumnName("ideal_moisture_percentage");

                    b.Property<int>("IdealTemperatureCelsius")
                        .HasColumnType("integer")
                        .HasColumnName("ideal_temperature_celsius");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text")
                        .HasColumnName("name");

                    b.Property<string>("SensorPort")
                        .IsRequired()
                        .HasColumnType("text")
                        .HasColumnName("sensor_port");

                    b.HasKey("Id");

                    b.HasIndex("SensorPort")
                        .IsUnique();

                    b.ToTable("plants");
                });

            modelBuilder.Entity("API.Entities.PlantReading", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("id");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("timestamp with time zone")
                        .HasColumnName("created_at");

                    b.Property<int>("Light")
                        .HasColumnType("integer")
                        .HasColumnName("light");

                    b.Property<int>("Moisture")
                        .HasColumnType("integer")
                        .HasColumnName("moisture");

                    b.Property<int>("TemperatureCelsius")
                        .HasColumnType("integer")
                        .HasColumnName("temperature");

                    b.HasKey("Id");

                    b.ToTable("plant_readings");
                });

            modelBuilder.Entity("API.Entities.Sensor", b =>
                {
                    b.Property<string>("Port")
                        .HasColumnType("text")
                        .HasColumnName("port");

                    b.HasKey("Port");

                    b.ToTable("sensors");

                    b.HasData(
                        new
                        {
                            Port = "A0"
                        },
                        new
                        {
                            Port = "A3"
                        },
                        new
                        {
                            Port = "A4"
                        },
                        new
                        {
                            Port = "A5"
                        });
                });

            modelBuilder.Entity("API.Entities.WaterReading", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("id");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("timestamp with time zone")
                        .HasColumnName("created_at");

                    b.Property<int>("Moisture")
                        .HasColumnType("integer")
                        .HasColumnName("moisture");

                    b.HasKey("Id");

                    b.ToTable("water_readings");
                });

            modelBuilder.Entity("API.Entities.Plant", b =>
                {
                    b.HasOne("API.Entities.Sensor", "Sensor")
                        .WithOne("Plant")
                        .HasForeignKey("API.Entities.Plant", "SensorPort")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Sensor");
                });

            modelBuilder.Entity("API.Entities.Sensor", b =>
                {
                    b.Navigation("Plant")
                        .IsRequired();
                });
#pragma warning restore 612, 618
        }
    }
}
