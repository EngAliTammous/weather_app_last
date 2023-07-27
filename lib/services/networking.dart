
import 'package:http/http.dart' as http;
import 'package:weather_app/Model/weatherModel.dart';

class NetworkHelper {
  final String url;
  NetworkHelper({required this.url , });

  Future<WeatherModel> getData({bool loading = true}) async {
    try{
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        WeatherModel jsonDecode = weatherModelFromJson(response.body); /*convert string body (response) to WeatherModel*/


        return jsonDecode; /*return and the return type is json*/

      }
    }catch(e){
      print('Not exit country');

    }
    return Future.error("something wrong");
  }
}
