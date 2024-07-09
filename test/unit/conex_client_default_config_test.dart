import 'package:conex/services/conex_client.dart';
import 'package:conex/services/conex_http_methods.dart';
import 'package:conex/services/default_headers_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Conex Client default config Enable/Disable state", () {
    group("Disable Default Config", () {
      test('should find ConexClient isEnableConfig is equal to false', () {
        ConexClient.instance.disableDefaultConfig();
        expect(ConexClient.instance.isEnableConfig, false);
      });
    });
    group("Enable Default Config", () {
      test('should find ConexClient isEnableConfig is equal to true', () {
        ConexClient.instance.enableDefaultConfig();
        expect(ConexClient.instance.isEnableConfig, true);
      });
    });
  });

  group("Conex set Default Config", () {
    // initial ConexClient with default config
    // !! here config is enabled by defualt
    Map<String, String> headers;
    setUpAll(() {
      ConexClient.instance.initial(
        defaultConfig: ConexDefaultConfig(
          defaultHeaders: ConexDefaultHeaders({"tokenId": "123"}),
          defaultParams: ConexDefaultParams({"lang": "ar"}),
        ),
      );
      headers = {
        'content-type': 'application/x-www-form-urlencoded; charset=utf-8',
        // default header values
        "tokenId": "123",
      };
    });

    // test("should find the default config included with request when is enabled", () {
    //   // send fake request
    //   ConexGet(url: "www.google.com/").send();
    // });
  });
}
