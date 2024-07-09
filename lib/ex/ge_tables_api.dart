import 'package:conex/models/responce_model.dart';
import 'package:conex/services/conex_client.dart';
import 'package:conex/interfaces/conex_methods.dart';

/// Model
class BookModel {
  final String title;
  final String subTitle;

  BookModel(this.title, this.subTitle);
  factory BookModel.fromJson(dynamic data) {
    return BookModel(data["title"], data["subTitle"]);
  }
}

class GetTablesApi extends ConexGet<List<BookModel>> {
  GetTablesApi() : super(encoding: null);

  @override
  String url = "http://www.localhost.com/";

  @override
  List<BookModel> format(data) {
    return (data as List).map((e) => BookModel.fromJson(e)).toList();
  }
}

test(ConexGet<List<BookModel>> conexMethod) async {
  ConexGet<List<BookModel>> getTables = conexMethod;

  // Lisend on the state of request (loading, complete, error, noInternet)
  getTables.requestState.addLisener((state) {
    print("State: $state");
  });

  // add some headers
  getTables.setHeader({"id": "10"});

  // add body if needed too
  getTables.setBody({"fullname": "mohamed"});

  ConexResponce<List<BookModel>> responce;

  // send the request
  responce = await getTables.send();

  // send the request without default config
  responce = await getTables.send(useConfig: false);
  // or you can disable default config by call
  ConexClient.instance.disableDefaultConfig();

  // remove lisener
  getTables.requestState.dispose();

  // other structure merge all the methods together
  final responceTwo = await getTables.setHeader({}).setBody({}).send(useConfig: false);
}

void main(List<String> args) {
  // Injection
  test(GetTablesApi());
}
