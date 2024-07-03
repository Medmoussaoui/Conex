import 'package:conex/interfaces/it_responce_exception.dart';
import 'package:conex/models/responce_model.dart';

class ServerFailerException extends ConexResponceException {
  ServerFailerException({required super.statusCode, super.err});

  @override
  ConexResponce<Data> handle<Data>() {
    return ConexResponce<Data>.serverError(statusCode: statusCode);
  }
}

class RespondErrorException extends ConexResponceException {
  RespondErrorException({required super.statusCode, super.err});

  @override
  ConexResponce<Data> handle<Data>() {
    return ConexResponce<Data>.respondError(statusCode: statusCode);
  }
}

class ConnectionException extends ConexResponceException {
  ConnectionException({required super.statusCode, super.err});

  @override
  ConexResponce<Data> handle<Data>() {
    return ConexResponce<Data>.internetProblem();
  }
}

class UnknowException extends ConexResponceException {
  UnknowException({required super.statusCode, super.err});

  @override
  ConexResponce<Data> handle<Data>() {
    return ConexResponce<Data>.respondError(statusCode: statusCode);
  }
}
