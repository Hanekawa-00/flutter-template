import 'package:hive_ce_flutter/hive_flutter.dart';

import '../logging/app_logger.dart';
import 'hive_key_value_store.dart';
import 'local_database.dart';

class HiveLocalDatabase implements LocalDatabase {
  HiveLocalDatabase({
    required AppLogger logger,
    this.subDirectory = 'flutter_template',
  }) : _logger = logger;

  final AppLogger _logger;
  final String subDirectory;

  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    await Hive.initFlutter(subDirectory);
    _initialized = true;
    _logger.info('Hive database initialized', name: 'storage');
  }

  Future<HiveKeyValueStore> openKeyValueStore(String name) async {
    await initialize();
    final box = await Hive.openBox<dynamic>(name);
    return HiveKeyValueStore(box);
  }

  @override
  Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }

  @override
  Future<void> deleteFromDisk() async {
    await close();
    await Hive.deleteFromDisk();
  }
}
