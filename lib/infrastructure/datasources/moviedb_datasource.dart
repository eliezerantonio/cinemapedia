import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/data/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/movie_mapper/movie_mapper.dart';
import 'package:dio/dio.dart';

class MoviedbDataSource extends MovieDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'pt-PT'
      },
    ),
  );
  @override
  Future<List<MovieEntity>> getNowPlay({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    List<MovieEntity> movies = movieDBResponse.results
        .where((movieDb) => !movieDb.posterPath.contains('no-post'))
        .map((movieDb) => MovieMaper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }
}
