import "package:flutter/material.dart";
import 'package:flutterapp2/widgets/layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import "../widgets/Form.dart";

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

fetchCityWeatherAsync(String city) {
  String url =
      'http://openweathermap.org/data/2.5/forecast?q=$city&appid=b6907d289e10d714a6e88b30761fae22';
  return http.get(url);
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city;

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Weather",
      onSubmit: () {
        if (!city.isEmpty) {
          fetchCityWeatherAsync(city).then((resp) {
            var weatherData = json.decode(resp.body)['list'];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherInfo(city, weatherData)));
          }).catchError((err) {
            print("no data for $city , $err");
          });
        }
      },
      onChanged: (value) {
        setState(() {
          city = value;
        });
      },
      value: city,
    );
  }
}

class WeatherInfo extends StatelessWidget {
  WeatherInfo(this.city, this.weatherInfos);

  List<dynamic> weatherInfos;
  final city;
  @override
  Widget build(BuildContext context) {
    return Layout(
        title: "Weather of city $city",
        body: ListView(
          children: <Widget>[
            ...weatherInfos.map((weather) => WeatherCard(weather))
          ],
        ));
  }
}

class WeatherCard extends StatelessWidget {
  WeatherCard(this.weather);

  final weather;
  @override
  Widget build(BuildContext context) {
    String icon = weather['weather'][0]['main'].toLowerCase();
    int timestamp = weather['dt'];

    return Card(
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/$icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "${DateFormat('E dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000000))}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000000))} | ${weather['weather'][0]['main']}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      //Text("Test"),
                      //Text("Text")
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "${weather['main']['temp'].round()} °C",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
