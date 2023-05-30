import 'package:cinemapedia/data/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/movie_mapper/actor_mapper.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
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
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castRsponse = CastResponse.fromJson(response.data);

    List<ActorEntity> actors =
        castRsponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }
}
