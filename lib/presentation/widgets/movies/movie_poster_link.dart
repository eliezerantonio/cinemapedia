import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie_entity.dart';

class MoviePosterLink extends StatelessWidget {
  const MoviePosterLink(this.movie, {super.key});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeIn(
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
