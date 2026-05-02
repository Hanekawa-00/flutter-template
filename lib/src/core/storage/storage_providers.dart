import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logging/logging_providers.dart';
import 'hive_key_value_store.dart';
import 'hive_local_database.dart';

final localDatabaseProvider = Provider<HiveLocalDatabase>((ref) {
  return HiveLocalDatabase(logger: ref.watch(appLoggerProvider));
});

final cacheStoreProvider = FutureProvider<HiveKeyValueStore>((ref) {
  return ref.watch(localDatabaseProvider).openKeyValueStore('cache');
});
