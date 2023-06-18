import '../../domain/entities/movie_entity.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(MovieEntity movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<MovieEntity>> loadMovies({int limite = 10, offset = 0});
}
