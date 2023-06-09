import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/data/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
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

  List<MovieEntity> _jsonRoMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    List<MovieEntity> movies = movieDBResponse.results
        .where((movieDb) => !movieDb.posterPath.contains('no-poster'))
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();

    return movies;
  }

  @override
  Future<List<MovieEntity>> getNowPlay({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonRoMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonRoMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonRoMovies(response.data);
  }

  @override
  Future<List<MovieEntity>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonRoMovies(response.data);
  }

  @override
  Future<MovieEntity> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final MovieEntity movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonRoMovies(response.data);
  }
}
