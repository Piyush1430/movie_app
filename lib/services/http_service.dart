import '../models/app_config.dart';

//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? _base_url;
  String? _api_key;

  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    _base_url = config.BASE_API_URL;
    _api_key = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_base_url$path';
      Map<String, dynamic> query0 = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      if (query != null) {
        query0.addAll(query);
      }
      return await dio.get(url, queryParameters: query0);
    } on DioException catch (e) {
      print('Unable to perform get request.');
      print('DioError:$e');
    }
    return null;
  }
}
