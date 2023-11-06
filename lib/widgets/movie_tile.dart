//Packags
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
//Models
import "package:movie_app/models/movie.dart";

class MovieTile extends StatelessWidget {
  MovieTile(
      {Key? key,
      required this.movie,
      required this.height,
      required this.width})
      : super(key: key);
  final GetIt _getIt = GetIt.instance;
  final Movie movie;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _moviePosterPath(movie.posterURL()),
        _movieInfoWidget(),
      ],
    );
  }

  Widget _movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.55,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 22),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              "${movie.language} | R:${movie.isAdult} | ${movie.releaseDate} ",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.description,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterPath(String imageURL) {
    return Container(
      height: height,
      width: width*0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageURL),
        ),
      ),
    );
  }
}
