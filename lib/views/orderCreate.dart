import 'package:flutter/material.dart';

class OrderCreate extends StatefulWidget {
  @override
  _OrderCreateState createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {
  String _name, _note, _createdate;
  bool otomatikKontrol = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            accentColor: Colors.green,
            hintColor: Colors.indigo,
            errorColor: Colors.red,
            primaryColor: Colors.teal),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.save),
          ),
          appBar: AppBar(
            title: Text("Yeni Sipariş Ekle"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              autovalidate: otomatikKontrol,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 25,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Sipariş Adını Giriniz",
                      hintStyle: TextStyle(fontSize: 12),
                      labelText: "Sipariş",
                      border: OutlineInputBorder(),
                    ),
                    //initialValue: "emre",
                    validator: _isimKontrol,
                    onSaved: (deger) => _name = deger,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 100,
                    maxLines: 3,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.comment),
                      hintText: "Sipariş Açıklamasını Giriniz",
                      labelText: "Açıklama",
                      border: OutlineInputBorder(),
                    ),
                    validator: _aciklamaKontrol,
                    onSaved: (deger) => _note = deger,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("KAYDET"),
                    color: Colors.blueAccent,
                    disabledColor: Colors.amber,
                    onPressed: _girisBilgileriniOnayla,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _girisBilgileriniOnayla() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      FocusScope.of(context).unfocus();
      _createdate = DateTime.now().toString();
      debugPrint("Girilen name: $_name note:$_note date:$_createdate");
      var snackBar = Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("$_name ->")));
      snackBar.closed.then((value) => Navigator.pop(context));
    } else {
      setState(() {
        otomatikKontrol = true;
      });
    }
  }

  String _aciklamaKontrol(String aciklama) {
    if (aciklama.length > 100)
      return 'En fazla 100 karakter';
    else
      return null;
  }

  String _isimKontrol(String isim) {
    if (isim.length < 3 || isim.length > 100)
      return '3-100 karakter arası olmalı';
    else
      return null;
  }
}
