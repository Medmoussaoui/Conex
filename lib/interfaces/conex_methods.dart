import 'package:conex/interfaces/it_conex_method.dart';

/// Conex Http GET Method
///
abstract class ConexGet<Data> extends ConexMethod<Data> {
  ConexGet({super.encoding}) : super(method: "GET");
}

/// Conex Http POST Method
///
abstract class ConexPost<Data> extends ConexMethod<Data> {
  ConexPost({super.encoding}) : super(method: "POST");
}

/// Conex Http PUT Method
///
abstract class ConexPut<Data> extends ConexMethod<Data> {
  ConexPut({super.encoding}) : super(method: "PUT");
}

/// Conex Http DELETE Method
///
abstract class ConexDelete<Data> extends ConexMethod<Data> {
  ConexDelete({super.encoding}) : super(method: "DELETE");
}
