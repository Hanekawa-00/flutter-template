import '../../core/network/api_client.dart';
import 'repository.dart';

final class HealthRepository extends BaseRepository {
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

  Future<RepositoryResult<Map<String, dynamic>>> fetchHealthResult() {
    return guard(fetchHealth, failureMessage: 'Failed to fetch health status.');
  }
}
