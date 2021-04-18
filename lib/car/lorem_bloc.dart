import 'package:cars/shared/generic_bloc.dart';
import 'package:cars/shared/services/base_api.dart';
import 'package:http/http.dart';

class LoremBloc extends GenericBloc<String> {
  fetch() async {
    try {
      String s = await LoripsumApi().get();
      add(s);
    } catch (e, exception) {
      addError(e);
      print('>>>>>>>> $e >>>>> $exception');
      throw Exception(e);
    }
  }
}

class LoripsumApi extends BaseApi {
  Future<String> get() async {
    final Response response = await apiGet("https://loripsum.net/api", {});
    if (response.statusCode == 200) {
      String s = response.body.toString();

      s = s.replaceAll("<p>", "");
      s = s.replaceAll("</p>", "");

      return s;
    }
    return throw Exception("Bad request");
  }
}
