class CacheEntry<T> {
  const CacheEntry({
    required this.value,
    required this.createdAt,
    this.expiresAt,
  });

  final T value;
  final DateTime createdAt;
  final DateTime? expiresAt;

  bool isExpired(DateTime now) {
    final expiresAt = this.expiresAt;
    return expiresAt != null && !expiresAt.isAfter(now);
  }
}
