import 'package:cars/shared/services/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client baseClient = HttpClientWithInterceptor.build(
  requestTimeout: Duration(seconds: 15),
  interceptors: [
    LoggingInterceptor(),
  ],
);

const String baseUrlV1 = 'https://carros-springboot.herokuapp.com/api/v1';
const String baseUrlV2 = "https://carros-springboot.herokuapp.com/api/v2";
