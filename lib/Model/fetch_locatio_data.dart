import 'package:weather_app/Model/weatherModel.dart';
import '../services/location.dart';
import '../services/networking.dart';
import '../utilities/constants.dart';

class FetchLocationData {
  Future<WeatherModel> getCurrentLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$kApiKey&units=metric");

    WeatherModel? weatherInfo = await networkHelper.getData();

    return weatherInfo!;
  }

  Future<WeatherModel> getTempBasedLocationSelect({required double lat ,required double long}) async {


    NetworkHelper networkHelper = NetworkHelper(

        url:
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric");

    WeatherModel weatherInfo = await networkHelper.getData();

        return weatherInfo;


  }


}
