import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie_entity.dart';
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, MovieEntity>>((ref){
  
  final movieRepository = ref.watch( movieRepositoryProvider );

  return MovieMapNotifier(getMovie: movieRepository.getMovieById );
});



typedef GetMovieCallback = Future<MovieEntity>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,MovieEntity>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({ required this.getMovie}): super({});


  Future<void> loadMovie( String movieId ) async {

    if( state[movieId] != null ) return;
    final movie = await getMovie( movieId );

    state = {...state, movieId: movie };
  }


}