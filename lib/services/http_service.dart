//Packages
// ignore_for_file: avoid_print

import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

//models
import "package:movie_app/models/app_config.dart";

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? baseUrl;
  String? apiKey;

  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    baseUrl = config.BASE_API_URL;
    apiKey = config.API_KEY;
  }

  Future<Response?> get(String path,
      {required Map<String, dynamic>? otherQuery}) async {
    try {
      String url = "$baseUrl$path";
      Map<String, dynamic> query = {
        "api_key": apiKey,
        "language": "en-Us",
      };
      if (otherQuery != null) {
        query.addAll(otherQuery);
      }
      return await dio.get(url,queryParameters: query);
    } on DioException catch (e) {
      print("Uable to load request");
      print("DioError:$e");
    }
    return null;
  }
}
