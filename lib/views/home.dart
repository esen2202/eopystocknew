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
            )
          ],
        ),
      ),
    );
  }
}
