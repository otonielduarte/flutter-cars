import 'dart:convert';
import 'dart:io';

import 'package:cars/shared/services/base_api.dart';
import 'package:cars/shared/upload/upload_model.dart';
import 'package:http/http.dart';

class UploadApi extends BaseApi {
  Future<String> uploadImage(UploadModel file) async {
    String url = "https://carros-springboot.herokuapp.com/api/v2/upload";
    try {
      final json = jsonEncode(file.toJson());
      final Response response = await client
          .post(Uri.parse(url), headers: await getHeaders(), body: json)
          .timeout(Duration(seconds: 50));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['url'];
      }
      throw HttpException('Fail create image');
    } catch (error, exception) {
      print('Unexpected error $error > $exception');
      throw HttpException('Fail create image');
    }
  }
}
