import '../services/conex_client.dart';

typedef HeadresMap = Map<String, String>;

class Headers {
  final HeadresMap _values = {};

  HeadresMap values() => _values;

  void includeDefultValues() {
    if (ConexClient.config == null) return;
    final defaultHeaders = ConexClient.config!.defaultHeaders;
    if (defaultHeaders != null) {
      _values.addAll(defaultHeaders.headers);
    }
  }

  void excludeDefaultValues() {
    if (ConexClient.config == null) return;
    final defaultHeaders = ConexClient.config!.defaultHeaders;
    if (defaultHeaders == null) return;
    // remove default added values
    for (String key in defaultHeaders.headers.keys) {
      _values.remove(key);
    }
  }

  void add(String key, String value) {
    _values.addAll({key: value});
  }

  void addAll(HeadresMap values) {
    _values.addAll(values);
  }

  void remove(String key) => _values.remove(key);
}
