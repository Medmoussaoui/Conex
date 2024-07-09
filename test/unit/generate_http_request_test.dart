import 'package:conex/common/functions/generate_http_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Generate Http Request", () {
    String baseUrl = "http://www.localhost.com/";
    final headers = {
      "useSecurity": "true",
      'content-type': 'application/x-www-form-urlencoded; charset=utf-8',
    };

    final body = {"name": "mohamed", "age": "15"}.toString();

    final request = generateRequest(
      method: "GET",
      url: Uri.parse(baseUrl),
      headers: headers,
      body: body,
    );

    request.body;

    test("request method should equal 'GET'", () {
      expect(request.method, "GET");
    });
    test("request headers should equal specified headrs", () {
      expect(request.headers, equals(headers));
    });

    test("request body should equal specified body", () {
      expect(request.body, equals(body));
    });
  });
}
