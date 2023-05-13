import 'package:cinemapedia/data/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

import '../../data/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {

  final MovieDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlay(page: page);
  }
}
