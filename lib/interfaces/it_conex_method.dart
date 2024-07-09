import 'dart:convert';
import 'dart:io';
import 'package:conex/common/exceptions/responce_exceptions.dart';
import 'package:conex/common/functions/generate_http_request.dart';
import 'package:conex/services/conex_client.dart';
import 'package:conex/models/conex_params.dart';
import 'package:conex/models/request_model.dart';
import 'package:conex/models/responce_model.dart';
import '../common/functions/add_url_parametrs.dart';
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
  Headers headers = Headers(ConexClient.instance);

  /// Http Parameters
  ///
  /// key-value pairs that are appended to the URL when making an HTTP request
  ///
  Params params = Params(ConexClient.instance);

  /// HTTP Message Body
  ///
  /// is the data bytes transmitted in an HTTP transaction
  /// message immediately following the headers if there are any
  ///
  dynamic _body;

  /// Format Body Responce
  ///
  /// [format] the incoming body message to any custom Dart object.
  /// json<of book item> to Book Model.fromJson(body)
  ///
  Data format(dynamic data);

  /// HTTP Request
  ///
  Future<http.Response> __excuteHttpMethod() async {
    final request = generateRequest(
      method: method,
      url: Uri.parse(addParametersToUrl(url, params.values())),
      body: _body,
      encoding: encoding,
      headers: headers.values(),
    );
    return http.Response.fromStream(await request.send());
  }

  ///
  /// [excuteHttpMethodHandle] is a primary call to execute
  /// the [__excuteHttpMethod] to handle and throw Unsuccess
  /// Responses as [ConexResponceException]
  ///
  Future<http.Response> excuteHttpMethodHandle() async {
    late int statusCode;
    try {
      http.Response responce = await __excuteHttpMethod();
      statusCode = responce.statusCode;
      if (statusCode >= 500) {
        throw ServerFailerException(statusCode: statusCode);
      }
      if (statusCode >= 400 && statusCode < 500) {
        throw RespondErrorException(statusCode: statusCode);
      }
      return responce;
    } catch (err) {
      if (err is HandshakeException || err is http.ClientException || err is SocketException) {
        throw ConnectionException(err: err, statusCode: statusCode);
      }
      rethrow;
    }
  }

  /// Private Send Request
  ///
  /// to handle all the faces of sending requests: notify for process states
  /// [requestState] and handle all Exceptions
  /// can lisen on the request life cycle: [requestState].addLisener((state) =>do)
  ///
  Future<ConexResponce<Data>> _send({bool? thorwErr}) async {
    try {
      requestState.loading();
      http.Response res = await excuteHttpMethodHandle();
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
      return ConexClient.instance.responceExceptionsFactory.handle(err);
    } finally {
      _body = null;
    }
  }

  /// Send Request
  ///
  /// After setting params, headers and body, call the [send] methods
  /// to execute the HTTP request and return the [ConexResponce]
  /// with the formatted body if Implement [format] for success Response
  ///
  /// When the [send] method execution ends with a successful or unsuccess
  /// response the [send] method will clear the set body if it has been set,
  /// to be ready for the new Send Request with New body data
  ///
  Future<ConexResponce<Data>> send({
    //
    // ignore return ConexResponce with throw the exceptions
    //
    bool? thorwErr,
    //
    // is false the request did not use the default config
    // else will use it by default.
    //
    bool? useConfig,
  }) async {
    __useOrNotUseConfi(use: useConfig);
    return _send(thorwErr: thorwErr);
  }

  /// if use ot equal to true will use the config by default if
  /// the conexClient instance not disable default config
  ///
  __useOrNotUseConfi({bool? use}) {
    if (use != false) {
      headers.includeDefultValues();
      params.includeDefultValues();
    } else {
      headers.excludeDefaultValues();
      params.excludeDefaultValues();
    }
  }

  /// Set Request Header
  ///
  /// set a map with key-value pairs, you can update the header
  /// value by call [setHeader] again with the same key and new value
  /// Ex: {key: newValues,...}
  ///
  ConexMethod<Data> setHeader(HeadresMap values) {
    headers.addAll(values);
    return this;
  }

  /// Set Request Parameters
  ///
  /// set a map with key-value pairs, you can update the params
  /// value by call [setParams] again with the same key and new value
  /// Ex: {id:10, name:"newValue",...}
  /// URL: "http://www.localhost.com/?id=10&name=newValue"
  ///
  ConexMethod<Data> setParams(ParamsMap values) {
    params.addAll(values);
    return this;
  }

  /// Set Request Body
  ///
  /// the type of data that the request body accepts depends
  /// on the HTTP method being used
  /// Types Example:
  ///
  /// 1- JSON (application/json): This is the most common format for RESTful APIs.
  /// 2- Form Data (application/x-www-form-urlencoded): This is used for sending simple key-value pairs.
  /// 3- Multipart Form Data (multipart/form-data): This is used for file uploads.
  /// 4- Plain Text (text/plain): This is used for sending raw text data.
  ///
  ConexMethod<Data> setBody(dynamic body) {
    _body = body;
    return this;
  }
}
