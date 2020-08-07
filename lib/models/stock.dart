import 'package:flutter/foundation.dart';

class Stock {
  final String stockCode;
  final int amount;
  String status;

  Stock({@required this.stockCode, @required this.amount, this.status});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      stockCode: json['StockCode'] as String,
      amount: json['Amount'] as int,
      status: json['Status'] as String,
    );
  }
}
