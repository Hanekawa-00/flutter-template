import '../storage/key_value_store.dart';
import 'cache_entry.dart';

typedef JsonMap = Map<String, dynamic>;

class JsonCacheStore {
  const JsonCacheStore(this._store, {DateTime Function()? clock})
    : _clock = clock;

  final KeyValueStore _store;
  final DateTime Function()? _clock;

  Future<void> put(String key, JsonMap value, {Duration? ttl}) async {
    final now = _now();
    await _store.write<JsonMap>(key, {
      'createdAt': now.toIso8601String(),
      'expiresAt': ttl == null ? null : now.add(ttl).toIso8601String(),
      'value': value,
    });
  }

  Future<CacheEntry<JsonMap>?> get(String key) async {
    final raw = await _store.read<JsonMap>(key);
    if (raw == null) {
      return null;
    }

    final entry = _entryFromJson(raw);
    if (entry.isExpired(_now())) {
      await _store.delete(key);
      return null;
    }

    return entry;
  }

  Future<JsonMap?> getValue(String key) async {
    return (await get(key))?.value;
  }

  Future<void> remove(String key) {
    return _store.delete(key);
  }

  Future<void> clear() {
    return _store.clear();
  }

  Stream<KeyValueStoreEvent> watch({String? key}) {
    return _store.watch(key: key);
  }

  CacheEntry<JsonMap> _entryFromJson(JsonMap json) {
    return CacheEntry<JsonMap>(
      value: Map<String, dynamic>.from(json['value'] as Map),
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );
  }

  DateTime _now() {
    return _clock?.call() ?? DateTime.now();
  }
}
