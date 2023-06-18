import 'dart:io';

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:isar/isar.dart';
import '../../data/datasources/local_storage_datasource.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalStorageDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarLocalStorageDatasource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieEntitySchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final MovieEntity? isFavoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limite = 10, offset = 0}) async {
    final isar = await db;

    return isar.movieEntitys.where().offset(offset).limit(limite).findAll();
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movieEntitys.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movieEntitys.deleteSync(favoriteMovie.isarId!));
      return;
    }

    isar.writeTxnSync(() => isar.movieEntitys.putSync(movie));
  }
}
