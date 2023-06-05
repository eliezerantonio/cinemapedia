import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie_entity.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');


final searchedMoviesProvider =    StateNotifierProvider<SearchedMoviesNotifier, List<MovieEntity>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(searchMovies: movieRepository.searchMovies, ref: ref);
});

typedef SerchMoviesCallback = Future<List<MovieEntity>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  
  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  final SerchMoviesCallback searchMovies;
  final Ref ref;

  Future<List<MovieEntity>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final List<MovieEntity> movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}
