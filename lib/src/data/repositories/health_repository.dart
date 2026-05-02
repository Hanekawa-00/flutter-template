import '../../core/network/api_client.dart';
import 'repository.dart';

class HealthRepository implements Repository {
  const HealthRepository(this._client);

  final ApiClient _client;

  @override
  String get name => 'health';

  Future<Map<String, dynamic>> fetchHealth() {
    return _client.get<Map<String, dynamic>>(
      '/health',
      decode: (data) => Map<String, dynamic>.from(data as Map),
    );
  }
}
