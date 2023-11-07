//Package
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

//Models
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/search_category.dart';

//Services
import '../services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.inital()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie>? movies = [];

      if (state.searchText!.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await (_movieService.getPopularMovies(page: state.page));
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await (_movieService.getUpcomingMovies(page: state.page));
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        movies = await (_movieService.searchMovies(state.searchText));
      }
      state = state.copyWith(
          movies: [...state.movies!, ...movies!], page: state.page! + 1);
    } catch (e) {
      print(e);
    }
  }

  void updateSearchCategory(String? category) {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: '');
      getMovies();
    } catch (e) {
      print(e);
    }
  }

  void updateTextSearch(String searchText) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCategory.none,
          searchText: searchText);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
