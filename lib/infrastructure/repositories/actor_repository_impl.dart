import 'package:cinemapedia/data/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';

import '../../data/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
