import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const apiKey = '96f6fab893034d4a94355306231209';
  String weatherIcon = 'heavycloud.png';
  double temperature = 0;
  double windspeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';
  String location = 'barisal';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherForecast = '';
  String currentWeatherStatus = '';

  String searchWeatherApi =
      'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=';

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherApi + searchText));
      final weatherData = Map<String, dynamic>.from(
        json.decode(searchResult.body) ?? 'no data',
      );
      //print(weatherData);
      var locationData = weatherData['location'];
      //print(locationData);
      var currentWeather = weatherData['current'];
      //print(currentWeather);
      setState(() {
        //set location
        location = getShortLoactionName(locationData['name']);
        //formatting date like "Wednesday, September 13"
        var parseDate =
            DateTime.parse(locationData['localtime'].substring(0, 10));
        //print(parseDate);
        var newDate = DateFormat.MMMMEEEEd().format(parseDate);
        var currentDate = newDate;
        //print(currentDate);

        //updateWeather
        currentWeatherStatus = currentWeather['condition']['text'];
        //print(currentWeatherStatus);
        weatherIcon =
            '${currentWeatherStatus.replaceAll('', '').toLowerCase()}.png';
        //print(weatherIcon);
        temperature = currentWeather['temp_c'];
        //print(temperature);
        windspeed = currentWeather['wind_kph'];
        //print(windspeed);
        humidity = currentWeather['humidity'].toInt();
        //sprint(humidity);
        cloud = currentWeather['cloud'].toInt();
        //print(cloud);
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  static String getShortLoactionName(String s) {
    List<String> wordList = s.split(' ');
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        return wordList[0];
      }
    } else {
      return ' ';
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather info'),
      ),
    );
  }
}
