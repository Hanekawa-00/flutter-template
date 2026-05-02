import 'package:hive_ce/hive.dart';

import 'key_value_store.dart';

class HiveKeyValueStore implements KeyValueStore {
  HiveKeyValueStore(this._box);

  final Box<dynamic> _box;

  @override
  Future<bool> containsKey(String key) async {
    return _box.containsKey(key);
  }

  @override
  Future<T?> read<T>(String key) async {
    final value = _box.get(key);

    if (value == null) {
      return null;
    }

    return value as T;
  }

  @override
  Future<void> write<T>(String key, T value) {
    return _box.put(key, value);
  }

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Stream<KeyValueStoreEvent> watch({String? key}) {
    return _box.watch(key: key).map((event) {
      return KeyValueStoreEvent(
        key: event.key.toString(),
        deleted: event.deleted,
        value: event.value,
      );
    });
  }
}
