import 'package:conex/common/exceptions/responce_exceptions.dart';
import 'package:conex/interfaces/it_responce_exception.dart';
import 'package:conex/models/responce_model.dart';
import '../../interfaces/it_responce_exceptions_factory.dart';

class ResponceExceptionsFactory implements ItResponceExceptionsFactory {
  @override
  ConexResponce<Data> handle<Data>(error) {
    if (error is ConexResponceException) return error.handle();
    return UnknowException(statusCode: 0, err: error).handle();
  }
}
