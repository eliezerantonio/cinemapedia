import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets.dart';

class MovieMasonry extends StatefulWidget {
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  final List<MovieEntity> movies;

  final VoidCallback? loadNextPage;

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(widget.movies[index])
              ],
            );
          }

          return MoviePosterLink(widget.movies[index]);
        },
      ),
    );
  }
}
