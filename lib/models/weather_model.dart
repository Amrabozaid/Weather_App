
class Weather{
  final String city;
  final String temperature;
  final String description;

  Weather({required this.city, required this.temperature, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(city: json['location']['name'],
     temperature: json['current']['temp_c'].toString(),
      description: json['current']['condition']['text']
    );
  }
}

