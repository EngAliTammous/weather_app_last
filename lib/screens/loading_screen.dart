import 'package:flutter/material.dart';
import 'package:weather_app/Model/fetch_locatio_data.dart';
import '../Model/weatherModel.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {

  getWeatherData() async {
    try {
      FetchLocationData fetchLocationData = FetchLocationData();

      WeatherModel weatherModel = await fetchLocationData.getCurrentLocation();

      if (mounted) {
        /*if we in the widget execute the widget and we use it before set State */
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LocationScreen(weatherModel: weatherModel)));
      }
    } catch(error){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title:const Text('Location Error'),
          content:const Text('Please enable location services for the app to work properly.'),
          actions: [
            TextButton(
              onPressed: () async {
                //Navigator.of(context).pop();

                getWeatherData();
               Navigator.pop(context);
              },
              child:const Text('OK'),
            ),
          ],
        ),
      );
    }

  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
