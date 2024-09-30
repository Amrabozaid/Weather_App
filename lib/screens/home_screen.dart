import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();

  final WeatherService _weatherService = WeatherService();
  Weather weatherData = Weather(city: '', temperature: '', description: '');

  @override
  void initState() {
    super.initState();
    _fetchWeather("");
  }

  void _fetchWeather(String city) async {
    var retreivedWeatherData = await _weatherService.getWeather(city);
    if(retreivedWeatherData!=null)
      weatherData = retreivedWeatherData!;
    setState(() {});
  }

  String? _validateCity(String? value){
    if (value == null || value.isEmpty){return "City is required";}else{return null;}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/BG2.jpg"),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Weather App",style: TextStyle(color: Colors.amber),),backgroundColor: Colors.transparent),
        body: LayoutBuilder(builder:(BuildContext context,BoxConstraints constraints){
          return Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [const Color.fromARGB(128, 144, 60, 159),const Color.fromARGB(128, 84, 7, 98)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                              )
                            ),
                            width: constraints.maxWidth*.9,
                            height: constraints.maxHeight*.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.amber),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.amber)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.amber)
                                      ),
                                      hintText: "Search...",
                                      labelText: "City",
                                      labelStyle: TextStyle(color: Colors.amber)
                                    ),
                                    controller: _cityController,
                                    validator: _validateCity,
                                  ),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.amber)
                                  ),
                                  onPressed: (){if(_formKey.currentState!.validate()){
                                    _fetchWeather(_cityController.text);
                                  }},
                                  child: const Text("Search", style: TextStyle(color: Colors.amber),)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: constraints.maxWidth*.9,
                      // height: constraints.maxHeight*.3,
                      child: ConditionalBuilder(
                        condition: weatherData.city!="",
                        builder: (c)=> ClipRect(
                          child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [const Color.fromARGB(128, 144, 60, 159),const Color.fromARGB(128, 84, 7, 98)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(weatherData.city,style: TextStyle(color: Colors.amber,fontSize: 32)),
                                      Text(weatherData.description,style: TextStyle(color: Colors.amber,fontSize: 26))
                                    ],
                                  ),
                                  Text("${weatherData.temperature.toString()}°C",style: TextStyle(color: Colors.amber,fontSize: 40)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        fallback: (c)=>const SizedBox(),
                      )
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
