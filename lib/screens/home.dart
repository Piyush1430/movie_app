import "dart:ui";
//Packages
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
//Widgets
import "package:movie_app/widgets/movie_tile.dart";
//Models
import "package:movie_app/models/search_category.dart";
import "package:movie_app/models/movie.dart";

class HomeScreen extends ConsumerWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late TextEditingController _serachFieldTextController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _serachFieldTextController = TextEditingController();
    return buildUI(_deviceHeight, _deviceWidth);
  }

  Widget buildUI(double deviceHeight, double deviceWidth) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroungWidget(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroungWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: NetworkImage(
                "https://e1.pxfuel.com/desktop-wallpaper/49/663/desktop-wallpaper-new-movie-posters-hollywood-movie-2022.jpg"),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, _deviceHeight * 0.02, 0),
      width: _deviceWidth * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding:
                EdgeInsetsDirectional.symmetric(vertical: _deviceHeight * 0.01),
            child: _moviesListWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      child: Row(
        children: [
          _searchFieldWidget(),
          _selectionCategoryWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    const border = InputBorder.none;
    return SizedBox(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _serachFieldTextController,
        onSubmitted: (inputText) {},
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: border,
          focusedBorder: border,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.white24,
          ),
          hintText: "Search....",
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white24,
        ),
      ),
    );
  }

  Widget _selectionCategoryWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (value) {},
      items: [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _moviesListWidget() {
    final List<Movie> movie = [];
    for (var i = 0; i < 20; i++) {
      movie.add(Movie(
          name: "Five Nights at Freddy's",
          language: "EN",
          isAdult: false,
          description:
              "Recently fired and desperate for work, a troubled young man named Mike agrees to take a position as a night security guard at an abandoned theme restaurant: Freddy Fazbear's Pizzeria. But he soon discovers that nothing at Freddy's is what it seems.",
          posterPath: "/A4j8S6moJS2zNtRR8oWF08gRnL5.jpg",
          backdropPath: "/t5zCBSB5xMDKcDqe91qahCOUYVV.jpg",
          rating:  8.2,
          releaseDate: "2023-10-25"));
    }
    if (movie.isNotEmpty) {
      return ListView.builder(
        itemCount: movie.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: _deviceHeight * 0.01, horizontal: 0),
            child: InkWell(
              onTap: () {},
              child: MovieTile(
                  movie: movie[index],
                  height: _deviceHeight * 0.20,
                  width: _deviceWidth * 0.85),
            ),
          );
        },
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
