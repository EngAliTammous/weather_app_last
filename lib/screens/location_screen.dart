import 'package:flutter/material.dart';
import 'package:weather_app/Model/weather.dart' as p;
import 'package:weather_app/Model/weatherModel.dart';
import 'package:weather_app/screens/city_screen.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherModel});
  final WeatherModel weatherModel;
  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {




  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen(weatherModel: widget.weatherModel),));
        },
        child: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
      ),
      body: Container(
        width: double.infinity,

        decoration:const BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
Color(0xFF383C61),
               Color(0xFF383C61),

               Color(0xFF6B6E77),
         ])
        ),
        child:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const  Spacer(),
                Text(dayName,style:const TextStyle(fontSize: 30,color: Colors.white),),
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(widget.weatherModel.main.temp.toString().substring(0,2),style: TextStyle(fontSize: 30,color: Colors.white),),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(widget.weatherModel.sys.country, style: const TextStyle(fontSize: 30,color: Colors.white),),
                    ),
                    Text(widget.weatherModel.name,style: const TextStyle(fontSize: 20,color: Colors.white),),

                  ],
                ),
                const  Spacer(),
             Text(
                 p.WeatherModelMessage().getWeatherIcon(id: widget.weatherModel.weather[0].id),
               style:const TextStyle(fontSize: 150),
             ),
                const  Spacer(),
                Text(p.WeatherModelMessage().getMessage(temp: widget.weatherModel.main.temp,),style: const TextStyle(fontSize: 24,color: Colors.white)),
               const  Spacer(),

                const  Text('Based on your phone data this is the temp today',style:const TextStyle(fontSize: 16,color: Colors.white),),
const Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
