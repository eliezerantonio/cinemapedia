import 'package:cinemapedia/data/repositories/local_storage_repository.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, MovieEntity>>((ref) {
  final localStorageRespository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRespository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {
  int page = 0;

  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier(this.localStorageRepository) : super({});

  Future<List<MovieEntity>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final tempMoviesMap = <int, MovieEntity>{};
    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }
}
