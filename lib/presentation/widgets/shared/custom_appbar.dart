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
                    final searchedMovies = ref.read(searchedMoviesProvider);

                    final searchQuery = ref.read(searchQueryProvider);
                    showSearch<MovieEntity?>(
                      context: context,
                      query: searchQuery,
                      delegate: SearchMovieDelegate(
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery, 
                      initialMovies: searchedMovies
                      ),
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
