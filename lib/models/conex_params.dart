import 'package:conex/services/conex_client.dart';

typedef ParamsMap = Map<String, String>;

class Params {
  final ConexClient conexClient;
  final ParamsMap _values = {};

  Params(this.conexClient);

  ParamsMap values() => _values;

  void includeDefultValues() {
    if (conexClient.config == null) return;
    final defaultParams = conexClient.config!.defaultParams;
    if (defaultParams != null) _values.addAll(defaultParams.params);
  }

  void excludeDefaultValues() {
    if (conexClient.config == null) return;
    final defaultParams = conexClient.config!.defaultParams;
    if (defaultParams == null) return;
    // remove default added values
    for (String key in defaultParams.params.keys) {
      _values.remove(key);
    }
  }

  void add(String key, String value) => _values.addAll({key: value});

  void addAll(ParamsMap values) => _values.addAll(values);

  void remove(String key) => _values.remove(key);
}
