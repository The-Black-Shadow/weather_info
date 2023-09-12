import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  double humidity = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherForecast = '';

  String searchWeatherApi =
      'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=';

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherApi + searchText));
      final weatherData = Map<String, dynamic>.from(
        json.decode(searchResult.body) ?? 'no data',
      );
      var locationData = weatherData['location'];
      var currentData = weatherData['current'];

      setState(() {
        print(locationData['name']);
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  @override
  void initState() {
    fetchWeatherData('london');
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
