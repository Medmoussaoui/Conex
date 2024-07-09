import 'package:conex/common/functions/add_url_parametrs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Add Url Parameters", () {
    String baseUrl = "http://www.localhost.com/";
    test("should return a valid url format", () {
      final url = addParametersToUrl(baseUrl, {"name": "mohamed"});
      expect(url, "$baseUrl?name=mohamed");
    });
  });
}
