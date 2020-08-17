import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "Default Deger");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eopy Stok Entegre",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey, Colors.lightBlueAccent]),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _textController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        fillColor: Colors.amber,
                        labelText: 'Name',
                        alignLabelWithHint: false,
                        prefixIcon: Icon(
                          Icons.access_alarm,
                          color: Colors.blueGrey,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text("Camera"),
                      onPressed: () => Navigator.pushNamed(context, "/camera"),
                    ),
                    RaisedButton(
                      child: Text("Settings"),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/settings"),
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
                    RaisedButton(
                      child: Text("Order Create"),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/orderCreate"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
