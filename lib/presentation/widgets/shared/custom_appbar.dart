import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/delegate/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              const Text('Cinemapedia'),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    final movieRepository = ref.read(movieRepositoryProvider);
                    showSearch<MovieEntity?>(
                      context: context,
                      delegate: SearchMovieDelegate(
                          searchMovies: movieRepository.searchMovies),
                    ).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
