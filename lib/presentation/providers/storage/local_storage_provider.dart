import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/isar_local_storage_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_imple.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarLocalStorageDatasource());
});
