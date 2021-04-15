import 'package:cars/shared/generic_bloc.dart';
import 'package:cars/shared/services/base_api.dart';
import 'package:http/http.dart';

class LoremBloc extends GenericBloc<String> {
  fetch() async {
    try {
      String s = await LoripsumApi.get();
      add(s);
    } catch (e, exception) {
      addError(e);
      print('>>>>>>>> $e >>>>> $exception');
      throw Exception(e);
    }
  }
}

class LoripsumApi {
  static Future<String> get() async {
    Uri url = Uri.parse("https://loripsum.net/api");

    final Response response = await baseClient.get(url);
    if (response.statusCode == 200) {
      String s = response.body.toString();

      s = s.replaceAll("<p>", "");
      s = s.replaceAll("</p>", "");

      return s;
    }
    return throw Exception("Bad request");
  }
}
