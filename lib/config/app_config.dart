import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String? _endpoint;

  static Future<void> initialize() async {
    if (kDebugMode) {
      // Modo desarrollo
      await dotenv.load(fileName: 'assets/env.development');
    } else {
      // Modo producción
      await dotenv.load(fileName: 'assets/env.production');
    }
    _endpoint = dotenv.env['ENDPOINT'];
  }

  static String get endpoint {
    if (_endpoint == null || _endpoint!.isEmpty) {
      throw Exception(
        'ENDPOINT no está configurado. Asegúrate de llamar a AppConfig.initialize() primero.',
      );
    }
    return _endpoint!;
  }

  static String buildUrl(String path) {
    final baseUrl = endpoint.endsWith('/') ? endpoint : '$endpoint/';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$baseUrl$cleanPath';
  }
}
