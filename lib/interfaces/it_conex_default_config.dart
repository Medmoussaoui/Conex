abstract class ConexDefaultHeaders {
  final Map<String, String> headers;
  ConexDefaultHeaders(this.headers);

  bool _active = true;
  bool get isEnabled => _active == true;

  void enable() => _active = true;
  void disable() => _active = false;
}

abstract class ConexDefaultParams {
  final Map<String, String> params;
  ConexDefaultParams(this.params);

  bool _active = true;
  bool get isEnabled => _active == true;

  void enable() => _active = true;
  void disable() => _active = false;
}

abstract class ConexConfig {
  final ConexDefaultHeaders? defaultHeaders;
  final ConexDefaultParams? defaultParams;

  ConexConfig({this.defaultHeaders, this.defaultParams});

  bool _active = true;
  bool get isEnabled => _active == true;

  void enable() => _active = true;
  void disable() => _active = false;
}
