import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;
  NetworkHelper(this.url);

  Future<dynamic> getLocationData() async {
    http.Response response = await http.get(Uri.parse(url));
    var data = response.body;

    try {
      if (response.statusCode == 200) {
        var weatherData = jsonDecode(data);

        return weatherData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
