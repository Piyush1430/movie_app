
import 'package:get_it/get_it.dart';
import 'package:movie_app/services/http_service.dart';

class Movieservice{
  final GetIt getIt = GetIt.instance;
  HTTPService? _httpService;
  Movieservice(){
    _httpService = getIt.get<HTTPService>();
  }

}