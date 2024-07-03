import 'dart:convert';
import 'package:http/http.dart';

Request generateRequest({
  required String method,
  required Uri url,
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) {
  var request = Request(method, url);
  if (headers != null) request.headers.addAll(headers);
  if (encoding != null) request.encoding = encoding;
  if (body != null) {
    if (body is String) {
      request.body = body;
    } else if (body is List) {
      request.bodyBytes = body.cast<int>();
    } else if (body is Map) {
      request.bodyFields = body.cast<String, String>();
    } else {
      throw ArgumentError('Invalid request body "$body".');
    }
  }
  return request;
}
