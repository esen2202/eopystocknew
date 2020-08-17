import 'dart:convert';
import 'package:eopystocknew/util/nothing.dart';
import 'package:eopystocknew/util/request_type.dart';
import 'package:eopystocknew/util/request_type_exception.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class RequestClient {
  static const String _baseUrl = "http://192.168.0.108:8080";
  final Client _client;

  RequestClient(this._client);

  Future<Response> request(
      {@required RequestType requestType,
      @required String path,
      dynamic parameter = Nothing}) async {
    //->
    switch (requestType) {
      case RequestType.GET:
        return _client.get("$_baseUrl/$path");
      case RequestType.POST:
        return _client.post("$_baseUrl/$path",
            headers: {"Content-Type": "application/json"},
            body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete("$_baseUrl/$path");
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
