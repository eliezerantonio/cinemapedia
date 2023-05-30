import 'package:cinemapedia/domain/entities/actor_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'actors_reposiory_provider.dart';

typedef GetActorsCallback = Future<List<ActorEntity>> Function(String movieId);

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,
    Map<String, List<ActorEntity>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

class ActorsByMovieNotifier
    extends StateNotifier<Map<String, List<ActorEntity>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actores = await getActors(movieId);

    state = {...state, movieId: actores};
  }
}
