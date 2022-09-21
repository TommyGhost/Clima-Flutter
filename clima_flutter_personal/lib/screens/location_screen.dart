import 'package:clima_flutter_personal/screens/city_screen.dart';
import 'package:clima_flutter_personal/services/weather.dart';
import 'package:clima_flutter_personal/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  var locationData;

  LocationScreen({required this.locationData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late int condition;
  late String cityName;
  late String weatherIcon;
  late String message;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationData);
  }

  void updateUI(weatherData) {
    if (weatherData == null) {
      temperature = 0;
      condition = 0;
      cityName = '';
      weatherIcon = '☀️';
      message = 'Unable to get weather';

      return;
    }
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    weatherIcon = weather.getWeatherIcon(condition);
    message = weather.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()));

                        var weatherData =
                            await weather.getCityWeather(typedName);
                        setState(() {
                          updateUI(weatherData);
                        });
                      } catch (e) {
                        throw 'Unable to get data';
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// '☀️'
