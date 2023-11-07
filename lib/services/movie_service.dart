//Packages
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

//Services
import '../services/http_service.dart';

//Models
import '../models/movie.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>?> getPopularMovies({int? page}) async {
    Response? response = await _http.get('/movie/popular', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load popular movies.');
    }
  }

  Future<List<Movie>?> getUpcomingMovies({int? page}) async {
    Response? response = await _http.get('/movie/upcoming', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load upcoming movies.');
    }
  }

  Future<List<Movie>?> searchMovies(String? seachTerm, {int? page}) async {
    Response? response = await _http.get('/search/movie', query: {
      'query': seachTerm,
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t perform movies search.');
    }
  }
}