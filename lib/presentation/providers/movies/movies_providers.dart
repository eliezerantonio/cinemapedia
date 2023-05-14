import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieCallback = Future<List<MovieEntity>> Function({int page});

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  bool isLoading = false;
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;

    final List<MovieEntity> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
