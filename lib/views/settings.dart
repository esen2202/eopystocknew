import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Home"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
