import 'dart:convert';
import 'dart:html';

import 'package:eopystocknew/models/stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StockApiService {
  final String url = "";

  //const HttpService({@required String this.url});

  Future<Stock> stoklariGerir() async {
    var result = await http.get(url);
    if (result.statusCode == 200) {
      return Stock.fromJsonMap(json.decode(result.body));
    } else {
      throw Exception("Bağlanamadı $result.statusCode");
    }
  }
}
