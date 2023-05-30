import '/domain/entities/movie_entity.dart';

abstract class MovieDatasource {
  Future<List<MovieEntity>> getNowPlay({int page = 1});

  Future<List<MovieEntity>> getPopular({int page = 1});

  Future<List<MovieEntity>> getUpcoming({int page = 1});

  Future<List<MovieEntity>> getTopRated({int page = 1});

  Future<MovieEntity> getMovieById(String id);

  Future<List<MovieEntity>> searchMovies(String query);
}
