import 'package:conex/services/conex_client.dart';

typedef ParamsMap = Map<String, String>;

class Params {
  final ParamsMap _values = {};

  ParamsMap values({bool useDefault = true}) {
    if (ConexClient.config != null) {
      final defaultParams = ConexClient.config!.defaultParams;
      if (defaultParams != null && defaultParams.isEnabled) {
        _values.addAll(defaultParams.params);
      }
    }
    return _values;
  }

  void add(String key, String value) {
    _values.addAll({key: value});
  }

  void addAll(ParamsMap values) {
    _values.addAll(values);
  }

  void remove(String key) => _values.remove(key);
}
