import 'package:conex/services/conex_methods.dart';

class GetTablesApi extends ConexGet<List<String>> {
  GetTablesApi() : super(encoding: null);

  @override
  String url = "http://www.";

  @override
  List<String> format(data) {
    return [data, ""];
  }
}

test() async {
  ConexGet<List<String>> getTables = GetTablesApi();

  // Lisend on the state of request (loading, complete, error, noInternet)
  getTables.requestState.addLisener((state) {
    print("State: $state");
  });

  // add some headers
  getTables.setHeader({"id": "10"});

  // add body if needed too
  getTables.setBody({"fullname": "mohamed"});

  // send the request
  final responce = await getTables.send();

  // remove lisener
  getTables.requestState.dispose();

  // other structure merge all the methods together
  final responceTwo = await getTables.setHeader({}).setBody({}).send(useConfig: false);
}
