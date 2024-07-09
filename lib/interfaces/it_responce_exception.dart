import 'package:conex/models/responce_model.dart';

abstract class ConexResponceException implements Exception {
  /// Http Responce Status Code
  ///
  /// are standard response codes given
  /// by web servers on the Internet. The codes help identify the
  /// status of the request made by a client to a server.
  ///
  final int statusCode;

  /// [err]
  ///
  /// It is the actual throws exception before wrapping it by [ConexResponceException]
  ///
  late dynamic err;

  ConexResponceException({
    this.err,
    required this.statusCode,
  });

  /// Custom handle methode
  ///
  /// return ConexResponce<Data> based on the specific exception
  ConexResponce<Data> handle<Data>();
}

/// Example: exception from Handshake Exception (ConexResponceNoInternerException)
/// 
/// ConexResponce<Data> handle() {
///     return ConexResponce.noInternet();
/// } 