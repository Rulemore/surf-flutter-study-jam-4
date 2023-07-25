import 'package:dio/dio.dart';

const String url = "https://eightballapi.com/api/";

class Network {
  static final dio = Dio();

  static Future<String> getAnswer() async {
    try {
      final response = await dio.get(url);
      return response.data["reading"];
    } catch (e) {
      return "Error";
      // return e.toString();
    }
  }
}
