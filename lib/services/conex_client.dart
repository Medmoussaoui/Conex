import 'package:conex/common/exceptions/responce_exceptions_factory.dart';
import 'package:conex/interfaces/it_conex_default_config.dart';
import 'package:conex/interfaces/it_responce_exceptions_factory.dart';
import 'package:http/http.dart' as http;

abstract class ConexClient {
  static ConexConfig? config;
  static http.Client? _client;
  static bool _useDefaultConfig = true;

  static late ItResponceExceptionsFactory responceExceptionsFactory;

  static http.Client get client {
    _client ??= http.Client();
    return _client!;
  }

  static initial({ConexConfig? defaultConfig}) {
    responceExceptionsFactory = ResponceExceptionsFactory();
    _useDefaultConfig = true;
    _client = http.Client();
    config = defaultConfig;
  }

  static enableDefaultConfig() => _useDefaultConfig = true;

  static disableDefaultConfig() => _useDefaultConfig = false;
}
