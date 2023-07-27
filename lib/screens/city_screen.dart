import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/Model/fetch_locatio_data.dart';
import 'package:weather_app/Model/weatherModel.dart';
import '../utilities/constants.dart';
import 'package:weather_app/Model/weather.dart' as p;

class CityScreen extends StatefulWidget {
   CityScreen({super.key ,required this.weatherModel});
 WeatherModel weatherModel ;
  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {

  String selectedCountry = 'Algeria';
  bool loading = false ;

  void showCountryPicker() async{
    final country = await showCountryPickerSheet(context,);
    if (country != null) {
      setState(() {
        selectedCountry = country.name;
        selectedCountry.toUpperCase();
        //print(country.name);

      });
      loading = true ;
      await init();
      loading = false ;
      setState(() { });

    }else if(country == null) {
     loading = false ;
     setState(() {

     });
    }
  }

  Future<List<double>> getLatLongFromCountry(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return [location.latitude, location.longitude];

      }
    } catch (e) {

      print("Error: $e");
    }
    return [];
  }

  double? latitude ;
  double? longitude ;


  init()async{
    print(selectedCountry);
    List<double> latLong  = await getLatLongFromCountry(selectedCountry);
    if(latLong.isNotEmpty){
      latitude = latLong[0];
      longitude = latLong[1];
      print('$latitude , $longitude');
      await getTempBasedLatLon();

    }

  }

  getTempBasedLatLon() async {
    try {
      FetchLocationData fetchLocationData = FetchLocationData();
      widget.weatherModel = await fetchLocationData.getTempBasedLocationSelect(lat: latitude!, long: longitude!);

    }catch(e){
      loading = false ;
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          title: Text('Not Data'),

        );
      },);
    }
    setState(() { }); // update ui

  }


  @override
  void initState()  {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            showCountryPicker();

        },
        child: const Icon(Icons.search,color: Colors.white,),
      ),

      body: loading? const Center(child: CircularProgressIndicator()) : Container(
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
                  child: Text(widget.weatherModel.main.temp.toString().substring(0,2),style:const TextStyle(fontSize: 30,color: Colors.white),),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                      Padding(
                        padding:const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(widget.weatherModel.sys.country, style: const TextStyle(fontSize: 30,color: Colors.white),),
                      ),
                    Text(widget.weatherModel.name,style:  const TextStyle(fontSize: 20,color: Colors.white),),

                  ],
                ),
                const  Spacer(),
                Text(
                  p.WeatherModelMessage().getWeatherIcon(id: widget.weatherModel.weather[0].id),
                  style:const TextStyle(fontSize: 150),
                ),
                const  Spacer(),
                Text(p.WeatherModelMessage().getMessage(temp: widget.weatherModel.main.temp,),style: const TextStyle(fontSize: 24,color: Colors.white)),
                Spacer(),
                const  Text('Based on your select country this is the temp today',style: TextStyle(fontSize: 16,color: Colors.white),),
                const Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
