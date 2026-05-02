import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_providers.dart';
import 'json_cache_store.dart';

final jsonCacheStoreProvider = FutureProvider<JsonCacheStore>((ref) async {
  final store = await ref.watch(cacheStoreProvider.future);
  return JsonCacheStore(store);
});
