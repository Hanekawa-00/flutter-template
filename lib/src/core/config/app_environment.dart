enum AppEnvironment {
  development(
    label: 'Development',
    apiBaseUrl: 'https://dev.example.com',
    enableVerboseLogs: true,
  ),
  staging(
    label: 'Staging',
    apiBaseUrl: 'https://staging.example.com',
    enableVerboseLogs: true,
  ),
  production(
    label: 'Production',
    apiBaseUrl: 'https://api.example.com',
    enableVerboseLogs: false,
  );

  const AppEnvironment({
    required this.label,
    required this.apiBaseUrl,
    required this.enableVerboseLogs,
  });

  final String label;
  final String apiBaseUrl;
  final bool enableVerboseLogs;

  static AppEnvironment fromName(String name) {
    final normalized = name.trim().toLowerCase();

    return switch (normalized) {
      'prod' || 'production' => AppEnvironment.production,
      'stage' || 'staging' => AppEnvironment.staging,
      _ => AppEnvironment.development,
    };
  }
}
