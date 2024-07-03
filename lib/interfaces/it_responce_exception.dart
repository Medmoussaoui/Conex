import 'package:conex/models/responce_model.dart';

abstract class ConexResponceException implements Exception {
  final int statusCode;
  late dynamic err;

  ConexResponceException({
    this.err,
    required this.statusCode,
  });

  ConexResponce<Data> handle<Data>();
}
