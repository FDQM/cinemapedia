import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMansory extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const MoviesMansory({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMansory> createState() => _MoviesMansoryState();
}

class _MoviesMansoryState extends State<MoviesMansory> {
final scrollController = ScrollController();

  @override
  void initState() {
     scrollController.addListener(() { 
      if(widget.loadNextPage == null) return;

      if(scrollController.position.pixels + 100 > scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MasonryGridView.count(
        controller: scrollController,
          itemCount: widget.movies.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          itemBuilder: (contex, index) {
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MoviePosterLink(movie: widget.movies[index])
                ],
              );
            }
            final movie = widget.movies[index];
            return MoviePosterLink(movie: movie);
          }),
    );
  }
}
