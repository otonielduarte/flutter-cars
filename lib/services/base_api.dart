import 'package:cars/services/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client baseClient = HttpClientWithInterceptor.build(
    requestTimeout: Duration(seconds: 5),
    interceptors: [
      LoggingInterceptor(),
    ]);

const String baseUrl = 'http://livrowebservices.com.br/rest/';
const String baseUrlV2 = "https://carros-springboot.herokuapp.com/api/v2";
