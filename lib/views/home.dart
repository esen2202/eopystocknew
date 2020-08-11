import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eopy Stok Entegre",
          style: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Camera"),
              onPressed: () => Navigator.pushNamed(context, "/camera"),
            ),
            RaisedButton(
              child: Text("Settings"),
              onPressed: () => Navigator.pushNamed(context, "/settings"),
            ),
            RaisedButton(
              child: Text("User"),
              onPressed: () => Navigator.pushNamed(context, "/user"),
            ),
            RaisedButton(
              child: Text("Stock"),
              onPressed: () => Navigator.pushNamed(context, "/stock"),
            ),
            RaisedButton(
              child: Text("Order"),
              onPressed: () => Navigator.pushNamed(context, "/order"),
            ),
          ],
        ),
      ),
    );
  }
}
