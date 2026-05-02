import 'dart:async';

import 'package:flutter_template/src/core/cache/json_cache_store.dart';
import 'package:flutter_template/src/core/storage/key_value_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonCacheStore', () {
    test('returns cached values before ttl expires', () async {
      var now = DateTime.utc(2026, 1, 1);
      final cache = JsonCacheStore(_MemoryKeyValueStore(), clock: () => now);

      await cache.put('profile', {
        'name': 'Codex',
      }, ttl: const Duration(hours: 1));
      now = now.add(const Duration(minutes: 30));

      final value = await cache.getValue('profile');

      expect(value, {'name': 'Codex'});
    });

    test('evicts expired values', () async {
      var now = DateTime.utc(2026, 1, 1);
      final store = _MemoryKeyValueStore();
      final cache = JsonCacheStore(store, clock: () => now);

      await cache.put('profile', {
        'name': 'Codex',
      }, ttl: const Duration(hours: 1));
      now = now.add(const Duration(hours: 2));

      final value = await cache.getValue('profile');

      expect(value, isNull);
      expect(await store.containsKey('profile'), isFalse);
    });

    test('can remove and clear values', () async {
      final cache = JsonCacheStore(_MemoryKeyValueStore());

      await cache.put('one', {'value': 1});
      await cache.put('two', {'value': 2});
      await cache.remove('one');

      expect(await cache.getValue('one'), isNull);
      expect(await cache.getValue('two'), {'value': 2});

      await cache.clear();

      expect(await cache.getValue('two'), isNull);
    });
  });
}

class _MemoryKeyValueStore implements KeyValueStore {
  final Map<String, Object?> _values = {};
  final StreamController<KeyValueStoreEvent> _events =
      StreamController<KeyValueStoreEvent>.broadcast();

  @override
  Future<void> clear() async {
    final keys = _values.keys.toList();
    _values.clear();
    for (final key in keys) {
      _events.add(KeyValueStoreEvent(key: key, deleted: true));
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    return _values.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
    _events.add(KeyValueStoreEvent(key: key, deleted: true));
  }

  @override
  Future<T?> read<T>(String key) async {
    return _values[key] as T?;
  }

  @override
  Stream<KeyValueStoreEvent> watch({String? key}) {
    if (key == null) {
      return _events.stream;
    }
    return _events.stream.where((event) => event.key == key);
  }

  @override
  Future<void> write<T>(String key, T value) async {
    _values[key] = value;
    _events.add(KeyValueStoreEvent(key: key, deleted: false, value: value));
  }
}
