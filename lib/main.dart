import 'package:eopystocknew/views/camera.dart';
import 'package:eopystocknew/views/home.dart';
import 'package:eopystocknew/views/orderCreate.dart';
import 'package:eopystocknew/views/order_ops/order_list.dart';
import 'package:eopystocknew/views/settings.dart';
import 'package:flutter/material.dart';
import 'controllers/stockController.dart';
import 'controllers/userController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage(),
          "/camera": (context) => CameraPage(title: "Camera"),
          "/settings": (context) => SettingsPage(),
          "/user": (context) => UserList(),
          "/stock": (context) => StockList(),
          "/order": (context) => OrderListPage(),
          "/orderCreate": (context) => OrderCreate(),
        });
  }
}
