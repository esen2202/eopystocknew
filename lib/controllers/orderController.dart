import 'dart:convert';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:eopystocknew/models/stockBarcode.dart';
import 'package:http/http.dart' as http;

class OrderController {
  final String _baseurl = "http://192.168.2.27:8080/";
  final String controller = "Order/";

  Future<List<Order>> getOrders() async {
    var response = await http.get(_baseurl + controller + "GetOrders");
    if (response.statusCode == 200) {
      return (json.decode(response.body)["Result"] as List)
          .map((order) => Order.fromJson(order))
          .toList();
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<Order> getOrder(int id) async {
    var response = await http.get(_baseurl + controller + "GetOrder/$id");
    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body)["Result"]);
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<StockBarcode> getStock(String barcode) async {
    var response = await http.get(_baseurl + controller + "GetStock/$barcode");
    if (response.statusCode == 200) {
      return StockBarcode.fromJson(json.decode(response.body)["Result"]);
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<List<OrderDetail>> getOrderDetails(int id) async {
    var response = await http
        .get(_baseurl + controller + "GetOrderDetails/" + id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body)["Result"] as List)
          .map((orderDetails) => OrderDetail.fromJson(orderDetails))
          .toList();
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

//-> its OK
  Future<Order> addUpdateOrder(Order order) async {
    String urlconcat = _baseurl + controller + "AddUpdateOrder";
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(order.toJson());

    var response = await http.post(urlconcat, headers: headers, body: json);

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body)["Result"]);
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

//-> its OK
  Future<OrderDetail> addUpdateOrderDetail(OrderDetail orderDetail) async {
    String urlconcat = _baseurl + controller + "AddUpdateOrderDetail";
    var json1 = jsonEncode(orderDetail.toJson());
    var response = await http.post(urlconcat,
        headers: {"Content-Type": "application/json"}, body: json1);

    if (response.statusCode == 200) {
      return OrderDetail.fromJson(jsonDecode(response.body)["Result"]);
    } else {
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<Order> changeStatusOrder(Order order, String status) async {
    String urlconcat = _baseurl + controller + "AddUpdateOrder";
    var oldStatus = order.status;
    order.status = status;
    var orderJson = jsonEncode(order.toJson());
    var response = await http.post(urlconcat,
        headers: {"Content-Type": "application/json"}, body: orderJson);

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body)["Result"]);
    } else {
      order.status = oldStatus;
      throw Exception("Bağlanamadı $response");
    }
  }

  Future<OrderDetail> changeStatusOrderDetail(
      OrderDetail orderDetail, String status) async {
    String urlconcat = _baseurl + controller + "AddUpdateOrderDetail";
    var oldStatus = orderDetail.status;
    orderDetail.status = status;
    var orderDetailJson = jsonEncode(orderDetail.toJson());
    var response = await http.post(urlconcat,
        headers: {"Content-Type": "application/json"}, body: orderDetailJson);

    if (response.statusCode == 200) {
      return OrderDetail.fromJson(jsonDecode(response.body)["Result"]);
    } else {
      orderDetail.status = oldStatus;
      throw Exception("Bağlanamadı $response");
    }
  }

//status -> "Deleted" - "" - "Archived"
  Future<List<OrderDetail>> changeStatusOrderDetails(
      List<OrderDetail> orderDetails, String status) async {
    var oldStatus = orderDetails != null ? orderDetails[0] : "";

    orderDetails.forEach((element) {
      element.status = status;
    });

    String urlconcat = _baseurl + controller + "DeleteStatusOrderDetails";
    var orderDetailJson = jsonEncode(orderDetails);
    var response = await http.post(urlconcat,
        headers: {"Content-Type": "application/json"}, body: orderDetailJson);

    if (response.statusCode == 200) {
      return (json.decode(response.body)["Result"] as List)
          .map((orderDetails) => OrderDetail.fromJson(orderDetails))
          .toList();
    } else {
      if (orderDetails == null) {
        orderDetails.forEach((element) {
          element.status = oldStatus;
        });
      }
      throw Exception("Bağlanamadı $response");
    }
  }
}
