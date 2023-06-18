import 'package:cinemapedia/data/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

import '../../data/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limite = 10, offset = 0}) {
    return datasource.loadMovies(limite: limite, offset: offset);
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) {
    return datasource.toggleFavorite(movie);
  }
}
