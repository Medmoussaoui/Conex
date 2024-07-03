import '../interfaces/it_conex_default_config.dart' as config;

class ConexDefaultHeaders extends config.ConexDefaultHeaders {
  ConexDefaultHeaders(super.headers);
}

class ConexDefaultParams extends config.ConexDefaultParams {
  ConexDefaultParams(super.headers);
}

class ConexDefaultConfig extends config.ConexConfig {
  ConexDefaultConfig({super.defaultHeaders, super.defaultParams});
}
