abstract interface class LocalDatabase {
  Future<void> initialize();

  Future<void> close();

  Future<void> deleteFromDisk();
}
