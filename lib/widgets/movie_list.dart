import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:movie_app/controllers/main_page_data_controller.dart";
import "package:movie_app/models/main_page_data.dart";
import "package:movie_app/models/movie.dart";
import "package:movie_app/widgets/movie_tile.dart";

// ignore: must_be_immutable
class MovieList extends ConsumerStatefulWidget {
  MovieList(
      {Key? key,
      required this.mainPageData,
      required this.mainPageDataController,
      this.selectedMoviePosterURL,
      required this.deviceHeight,
      required this.deviceWidth})
      : super(key: key);
  final MainPageData mainPageData;
  final MainPageDataController mainPageDataController;
  var selectedMoviePosterURL;
  final double deviceHeight;
  final double deviceWidth;

  @override
  ConsumerState<MovieList> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<MovieList> {
  @override
  Widget build(BuildContext context) {
    return _moviesListViewWidget();
  }

  Widget _moviesListViewWidget() {
    final List<Movie> movies = widget.mainPageData.movies!;

    if (movies.isNotEmpty) {
      return NotificationListener(
        onNotification: (dynamic onScrollNotification) {
          if (onScrollNotification is ScrollEndNotification) {
            final before = onScrollNotification.metrics.extentBefore;
            final max = onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              widget.mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: widget.deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedMoviePosterURL = movies[count].posterURL();
                  });
                },
                child: MovieTile(
                  movie: movies[count],
                  height: widget.deviceHeight * 0.30,
                  width: widget.deviceWidth * 0.84,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
