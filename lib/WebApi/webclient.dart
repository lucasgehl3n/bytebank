import 'package:bytebank/WebApi/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

const String urlBase = "192.168.1.93:8080";
