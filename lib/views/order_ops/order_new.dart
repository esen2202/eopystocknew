import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:flutter/material.dart';

class AddOrderPage extends StatelessWidget {
  final Order order;

  const AddOrderPage({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(order.id == null ? "Yeni Sipariş Tanımla" : order.name),
      ),
      body: SingleChildScrollView(
          child: OrderForm(order: order, child: AddOrderForm())),
    );
  }
}

class OrderForm extends InheritedWidget {
  final Order order;

  OrderForm({Key key, @required Widget child, @required this.order})
      : super(key: key, child: child);

  static OrderForm of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(OrderForm oldWidget) {
    return order.id != oldWidget.order.id;
  }
}

class AddOrderForm extends StatefulWidget {
  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final _formKey = GlobalKey<FormState>();
  OrderController _dbHelper;

  @override
  void initState() {
    _dbHelper = OrderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Order order = OrderForm.of(context).order;
    String resultmsg = "";
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Sipariş İsmi"),
                    initialValue: order.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "İsim Gerekli";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      order.name = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Not"),
                    initialValue: order.note,
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      order.note = value;
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Kaydet"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (order.id == null) {
                        order.id = 0;
                        order.status = "";
                        await _dbHelper.addUpdateOrder(order);
                      } else {
                        await _dbHelper.addUpdateOrder(order);
                      }
                      FocusScope.of(context).unfocus();
                      resultmsg = "${order.name} kaydedildi";
                      var snackBar = Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(resultmsg),
                          duration: Duration(microseconds: 1000),
                        ),
                      );

                      snackBar.closed.then((onValue) {
                        Navigator.pop(context, resultmsg);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
