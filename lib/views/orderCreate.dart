import 'package:flutter/material.dart';

class OrderCreate extends StatefulWidget {
  @override
  _OrderCreateState createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Oluşturma"),
        iconTheme: IconThemeData(size: 24, color: Colors.black, opacity: 0.5),
      ),
      body: Container(),
    );
  }
}
