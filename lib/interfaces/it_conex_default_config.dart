/// Default Conex Config
///
/// Conex provide the ability to add default headers [defaultHeaders]
/// or params [defaultParams] to pass them with any request and you can
/// disable or enable the provided default headers or params in any time
/// The benefits of default config, to pass authentication credentials And so on
///
abstract class ConexConfig {
  /// Default Headers
  ///
  final ConexDefaultHeaders? defaultHeaders;

  /// Default Params
  ///
  final ConexDefaultParams? defaultParams;

  ConexConfig({this.defaultHeaders, this.defaultParams});

  bool _active = true;

  /// isEnabled (default Config)
  ///
  /// to specify the config state, (true or false) to make sure to
  /// use the default config or not use it if it Is equal to false
  /// [isEnabled] state effect on both, [defaultHeaders] and [defaultParams] together
  ///
  bool get isEnabled => _active == true;

  /// Enable Config
  ///
  /// [isEnabled] will equal true and the Conex client will use
  /// the specific config (headers & params) with HTTP requests
  ///
  void enable() => _active = true;

  /// Disable Config
  ///
  /// [isEnabled] will equal false and the Conex client will NOT use
  /// the specific config (headers & params) with HTTP requests
  ///
  void disable() => _active = false;
}

/// Default Headers Config
///
/// It Takes the default headers to pass them automatically with
/// any request when the [isEnabled] state is equal to "true"
///
abstract class ConexDefaultHeaders {
  ConexDefaultHeaders(this.headers);

  /// heasders
  ///
  /// will store the default header values
  final Map<String, String> headers;

  bool _active = true;

  /// isEnabled (default headers Config)
  ///
  /// to specify the config state, (true or false) to make sure to
  /// use the default config or not use it if it Is equal to false
  /// [isEnabled] state effect only on [defaultHeaders]
  ///
  bool get isEnabled => _active == true;

  /// Enable Config
  ///
  /// [isEnabled] will equal true and the Conex client will use
  /// the specific headers config with HTTP requests
  ///
  void enable() => _active = true;

  /// Disable Config
  ///
  /// [isEnabled] will equal false and the Conex client will NOT use
  /// the specific headers config with HTTP requests
  ///
  void disable() => _active = false;
}

///
/// Default Params Config
///
/// It Takes the default Params to pass them automatically with
/// any request when the active state is equal to "true"
///
abstract class ConexDefaultParams {
  ConexDefaultParams(this.params);

  /// Params
  ///
  /// will store the default params values
  final Map<String, String> params;

  bool _active = true;

  /// isEnabled (default params Config)
  ///
  /// to specify the config state, (true or false) to make sure to
  /// use the default config or not use it if it Is equal to false
  /// [isEnabled] state effect only on [defaultParams]
  ///
  bool get isEnabled => _active == true;

  /// Enable Config
  ///
  /// [isEnabled] will equal true and the Conex client will use
  /// the specific params config with HTTP requests
  ///
  void enable() => _active = true;

  /// Disable Config
  ///
  /// [isEnabled] will equal false and the Conex client will NOT use
  /// the specific params config with HTTP requests
  ///
  void disable() => _active = false;
}
