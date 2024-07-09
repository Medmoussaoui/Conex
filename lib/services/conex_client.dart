import 'package:conex/common/exceptions/responce_exceptions_factory.dart';
import 'package:conex/interfaces/it_conex_default_config.dart';
import 'package:conex/interfaces/it_responce_exceptions_factory.dart';
import 'package:http/http.dart' as http;

class ConexClient {
  ConexConfig? config;
  http.Client? _client;
  bool _useDefaultConfig = true;

  late ItResponceExceptionsFactory responceExceptionsFactory;

  http.Client get client {
    _client ??= http.Client();
    return _client!;
  }

  bool get isEnableConfig => _useDefaultConfig;

  static ConexClient? _instance;

  static ConexClient get instance {
    _instance ??= ConexClient();
    return _instance!;
  }

  initial({ConexConfig? defaultConfig}) {
    responceExceptionsFactory = ResponceExceptionsFactory();
    config = defaultConfig;
    _useDefaultConfig = (config != null);
    _client = http.Client();
  }

  enableDefaultConfig() {
    _useDefaultConfig = true;
  }

  disableDefaultConfig() {
    _useDefaultConfig = false;
  }
}
