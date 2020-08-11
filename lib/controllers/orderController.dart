import 'dart:convert';

import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:eopystocknew/views/order.dart';
import 'package:http/http.dart' as http;

class OrderController {
  final String url = "http://192.168.2.27:8080/";
  final String controller = "Order/";

  Future<List<Order>> getOrderList() async {
    var response = await http.get(url + controller + "GetOrders");
    if (response.statusCode == 200) {
      return (json.decode(response.body)["Result"] as List)
          .map((order) => Order.fromJson(order))
          .toList();
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<Order> getOrder(int id) async {
    var response = await http.get(url + controller + "GetOrder/$id");
    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body)["Result"]);
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<List<OrderDetail>> getOrderDetails(int id) async {
    var response =
        await http.get(url + controller + "GetOrderDetails/" + id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body)["Result"] as List)
          .map((orderDetails) => OrderDetail.fromJson(orderDetails))
          .toList();
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }
}
