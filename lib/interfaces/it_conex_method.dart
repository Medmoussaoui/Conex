import 'dart:convert';
import 'dart:io';
import 'package:conex/common/exceptions/responce_exceptions.dart';
import 'package:conex/common/functions/generate_http_request.dart';
import 'package:conex/services/conex_client.dart';
import 'package:conex/models/conex_params.dart';
import 'package:conex/models/request_model.dart';
import 'package:conex/models/responce_model.dart';
import '../models/conex_header.dart';
import 'package:http/http.dart' as http;

abstract class ConexMethod<Data> {
  /// The HTTP method of the request.
  ///
  /// Most commonly "GET" or "POST", less commonly "HEAD", "PUT", or "DELETE".
  /// Non-standard method names are also supported.
  final String method;

  /// The form-encoded fields in the body of the request as a map from field
  /// names to values.
  ///
  /// The form-encoded body is converted to and from [bodyBytes] using
  /// [encoding] (in the same way as [body]).
  final Encoding? encoding;

  ConexMethod({required this.method, this.encoding});

  /// The URL to which the request will be sent.
  abstract String url;

  /// [RequestState] is the request life cycle:
  /// loading, complete, error, noInternet
  /// can add Listener to the request state to track the current state
  ///
  RequestState requestState = RequestState();

  /// HttpHeaders object
  ///
  /// Contain more information about the resource to be fetched,
  /// or about the client requesting the resource.
  ///
  Headers headers = Headers();

  /// Http Parameters
  ///
  /// key-value pairs that are appended to the URL when making an HTTP request
  ///
  Params params = Params();

  /// HTTP Message Body
  ///
  /// is the data bytes transmitted in an HTTP transaction
  /// message immediately following the headers if there are any
  ///
  dynamic _body;

  /// Format Body Responce
  ///
  /// [format] the incoming body message to any custom Dart object.
  /// json<of book item> to Book Model.from Json(body)
  /// 
  Data format(dynamic data);

  Future<http.Response> _excuteHttpMethod() async {
    final request = generateRequest(
      method: method,
      url: Uri.parse(url),
      body: _body,
      encoding: encoding,
      headers: headers.values(),
    );
    return http.Response.fromStream(await request.send());
  }

  /// witll throw conexResponceExceptions
  ///
  Future<http.Response> _excuteHttpMethodHandle() async {
    late int statusCode;
    try {
      http.Response responce = await _excuteHttpMethod();
      statusCode = responce.statusCode;
      if (statusCode >= 500) {
        throw ServerFailerException(statusCode: statusCode);
      }
      if (statusCode >= 400 && statusCode < 500) {
        throw RespondErrorException(statusCode: statusCode);
      }
      return responce;
    } catch (err) {
      if (err is HandshakeException || err is http.ClientException) {
        throw ConnectionException(err: err, statusCode: statusCode);
      }
      rethrow;
    }
  }

  Future<ConexResponce<Data>> _send({bool? thorwErr}) async {
    try {
      requestState.loading();
      http.Response res = await _excuteHttpMethodHandle();
      final responce = ConexResponce.success(bodyData: format(res.body));
      requestState.complete();
      return responce;
    } catch (err) {
      if (err is ConnectionException) {
        requestState.noInternet();
      } else {
        requestState.error();
      }
      if (thorwErr == true) rethrow;
      return ConexClient.responceExceptionsFactory.handle(err);
    }
  }

  Future<ConexResponce<Data>> send({
    bool? thorwErr,
    bool? useConfig,
  }) async {
    if (useConfig != false) {
      headers.includeDefultValues();
    } else {
      headers.excludeDefaultValues();
    }
    return _send(thorwErr: thorwErr);
  }

  ConexMethod<Data> setHeader(HeadresMap values) {
    headers.addAll(values);
    return this;
  }

  ConexMethod<Data> setBody(dynamic body) {
    _body = body;
    return this;
  }

  ConexMethod<Data> setParams(ParamsMap values) {
    params.addAll(values);
    return this;
  }
}
