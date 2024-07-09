import '../services/conex_client.dart';

typedef HeadresMap = Map<String, String>;

class Headers {
  final ConexClient conexClint;

  final HeadresMap _values = {};

  Headers(this.conexClint);

  HeadresMap values() => _values;

  void includeDefultValues() {
    if (conexClint.config == null) return;
    final defaultHeaders = conexClint.config!.defaultHeaders;
    if (defaultHeaders != null) _values.addAll(defaultHeaders.headers);
  }

  void excludeDefaultValues() {
    if (conexClint.config == null) return;
    final defaultHeaders = conexClint.config!.defaultHeaders;
    if (defaultHeaders == null) return;
    // remove default added values
    for (String key in defaultHeaders.headers.keys) {
      _values.remove(key);
    }
  }

  void add(String key, String value) => _values.addAll({key: value});

  void addAll(HeadresMap values) => _values.addAll(values);

  void remove(String key) => _values.remove(key);
}
