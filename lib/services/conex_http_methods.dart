import '../interfaces/conex_methods.dart' as methods;

class ConexGet<Data> extends methods.ConexGet<Data> {
  @override
  late String url;
  final Data Function(dynamic data)? formatBodyData;

  ConexGet({
    required this.url,
    this.formatBodyData,
  });

  @override
  Data format(data) {
    if (formatBodyData != null) return formatBodyData!(data);
    return data;
  }
}

class ConexPost<Data> extends methods.ConexPost<Data> {
  @override
  late String url;
  final Data Function(dynamic data)? formatBodyData;

  ConexPost({
    required this.url,
    this.formatBodyData,
  });

  @override
  Data format(data) {
    if (formatBodyData != null) return formatBodyData!(data);
    return data;
  }
}

class ConexPut<Data> extends methods.ConexPut<Data> {
  @override
  late String url;
  final Data Function(dynamic data)? formatBodyData;

  ConexPut({
    required this.url,
    this.formatBodyData,
  });

  @override
  Data format(data) {
    if (formatBodyData != null) return formatBodyData!(data);
    return data;
  }
}

class ConexDelete<Data> extends methods.ConexDelete<Data> {
  @override
  late String url;
  final Data Function(dynamic data)? formatBodyData;

  ConexDelete({
    required this.url,
    this.formatBodyData,
  });

  @override
  Data format(data) {
    if (formatBodyData != null) return formatBodyData!(data);
    return data;
  }
}
