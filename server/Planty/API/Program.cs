using API.Database;
using API.Repositories;
using API.Repositories.Impl;
using API.Services;
using API.Services.Impl;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Configuration.AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true).Build();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

if (builder.Environment.IsDevelopment()) {
    builder.Services.AddDbContext<DatabaseContext>(options => {
        options.UseNpgsql(builder.Configuration.GetValue<String>("ConnectionStrings:DEV"));
    });

} else {
    builder.Services.AddDbContext<DatabaseContext>(options => {
        options.UseNpgsql(builder.Configuration.GetValue<String>("ConnectionStrings:PRD"));
    });
}

builder.Services.AddScoped<IPlantRepository, PlantRepository>();
builder.Services.AddScoped<ISensorRepository, SensorRepository>();
builder.Services.AddScoped<IPlantReadingRepository, PlantReadingRepository>();

builder.Services.AddSingleton<ISerialService, SerialService>(provider => {
    var scopeFactory = provider.GetRequiredService<IServiceScopeFactory>();
    var port = builder.Configuration.GetValue<String>("SerialPort");
    return new SerialService(port!, scopeFactory);
});

builder.Services.AddSingleton<IReadingsService, SerialReadingService>(provider => {
    var serialService = provider.GetRequiredService<ISerialService>();
    var scopeFactory = provider.GetRequiredService<IServiceScopeFactory>();

    return new SerialReadingService(serialService, scopeFactory);
});



var app = builder.Build();

var serialService = app.Services.GetRequiredService<ISerialService>();
app.Lifetime.ApplicationStarted.Register(async () => await serialService.Start());
app.Lifetime.ApplicationStarted.Register(() => serialService.StartReading());

var readingService = app.Services.GetRequiredService<IReadingsService>();
app.Lifetime.ApplicationStarted.Register(() => readingService.StartTimers());

using var scope = app.Services.CreateScope();
var dbContext = scope.ServiceProvider.GetRequiredService<DatabaseContext>();
dbContext.Database.Migrate();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment()) {
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
