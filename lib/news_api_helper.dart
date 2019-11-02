import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  String url;
  String country;
  String myNewsApiKey = "";

  NetworkHelper({String generateUrl, String countryName}) {
    this.country = countryName;
    this.url =
        'https://newsapi.org/v2/top-headlines?country=$countryName&apiKey=$myNewsApiKey';
  }

  Future<Map> fetchNewsMapFromURL() async {
    print('reached here inside fewtch');
    print('url here is ${this.url}');
    Response response = await get(url);
    if (response.statusCode == 200) {
      print("response 200");
    }
    Map<String, dynamic> newsDataMap = jsonDecode(response.body);
    print(newsDataMap['articles'][0]['title']);
    return newsDataMap;
  }
}
