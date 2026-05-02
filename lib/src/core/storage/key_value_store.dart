abstract interface class KeyValueStore {
  Future<bool> containsKey(String key);

  Future<T?> read<T>(String key);

  Future<void> write<T>(String key, T value);

  Future<void> delete(String key);

  Future<void> clear();

  Stream<KeyValueStoreEvent> watch({String? key});
}

class KeyValueStoreEvent {
  const KeyValueStoreEvent({
    required this.key,
    required this.deleted,
    this.value,
  });

  final String key;
  final bool deleted;
  final Object? value;
}
