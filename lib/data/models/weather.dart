class WeatherInfo {
  int id;
  String location;
  String description;
  String icon;
  int temperature;
  int feelsLike;
  int min;
  int max;
  int pressure;
  int humidity;
  int visibility;
  int windSpeed;
  int windDirection;
  DateTime created;

  WeatherInfo(
    this.id,
    this.location,
    this.description,
    this.icon,
    this.temperature,
    this.feelsLike,
    this.min,
    this.max,
    this.pressure,
    this.humidity,
    this.visibility,
    this.windSpeed,
    this.windDirection,
    this.created,
  );

  factory WeatherInfo.fromJson(Map json) {
    int id = json['id'];
    String location = json['location'];
    String description = json['description'];
    String icon = json['icon'];
    int temperature = json['temperature'];
    int feelsLike = json['feelsLike'];
    int min = json['min'];
    int max = json['max'];
    int pressure = json['pressure'];
    int humidity = json['humidity'];
    int visibility = json['visibility'];
    int windSpeed = json['windSpeed'];
    int windDirection = json['windDirection'];
    DateTime created = DateTime.parse(json['created']['date']).toLocal();

    return WeatherInfo(
      id,
      location,
      description,
      icon,
      temperature,
      feelsLike,
      min,
      max,
      pressure,
      humidity,
      visibility,
      windSpeed,
      windDirection,
      created,
    );
  }
}
