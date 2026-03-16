import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central access point for all environment variables.
///
/// Usage:
///   final key = EnvConfig.secretKey;
class EnvConfig {
  EnvConfig._();

  static String get secretKey => _require('SECRET_KEY');

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Returns the value for [key] or throws a clear error at startup if missing.
  static String _require(String key) {
    final value = dotenv.maybeGet(key);
    assert(value != null && value.isNotEmpty,
        'EnvConfig: "$key" is missing or empty in your .env file.');
    return value ?? '';
  }
}