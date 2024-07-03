import 'package:conex/interfaces/it_conex_method.dart';

abstract class ConexGet<Data> extends ConexMethod<Data> {
  ConexGet({super.encoding}) : super(method: "GET");
}

abstract class ConexPost<Data> extends ConexMethod<Data> {
  ConexPost({super.encoding}) : super(method: "POST");
}

abstract class ConexPut<Data> extends ConexMethod<Data> {
  ConexPut({super.encoding}) : super(method: "PUT");
}

abstract class ConexDelete<Data> extends ConexMethod<Data> {
  ConexDelete({super.encoding}) : super(method: "DELETE");
}
