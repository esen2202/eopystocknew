import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddOrderDetailPage extends StatelessWidget {
  final OrderDetail orderDetail;
  final Order order;

  const AddOrderDetailPage(
      {Key key, @required this.orderDetail, @required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            orderDetail.id == null ? "Yeni Kalem Ekle" : orderDetail.stockCode),
      ),
      body: SingleChildScrollView(
          child: OrderDetailForm(
              orderDetail: orderDetail,
              order: order,
              child: AddOrderDetailForm())),
    );
  }
}

class OrderDetailForm extends InheritedWidget {
  final OrderDetail orderDetail;
  final Order order;

  OrderDetailForm(
      {Key key,
      @required Widget child,
      @required this.orderDetail,
      @required this.order})
      : super(key: key, child: child);

  static OrderDetailForm of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(OrderDetailForm oldWidget) {
    return orderDetail.id != oldWidget.orderDetail.id;
  }
}

class AddOrderDetailForm extends StatefulWidget {
  @override
  _AddOrderDetailFormState createState() => _AddOrderDetailFormState();
}

class _AddOrderDetailFormState extends State<AddOrderDetailForm> {
  final _formKey = GlobalKey<FormState>();
  OrderController _dbHelper;
  String _counter, _value = "";
  final _controller = TextEditingController();

  void _captureCode() async {
    _counter = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    if (_counter == "-1") {
      var snackBar = Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Okunamadı"),
          duration: Duration(microseconds: 2000),
        ),
      );

      snackBar.closed.then((onValue) {
        //Navigator.pop(context, "Okunamadı");
      });
    } else {
      try {
        var result = await _dbHelper.getStock(_counter);

        setState(() {
          _controller.text = result.stockCode;
        });
      } catch (e) {
        var snackBar = Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: Duration(microseconds: 2000),
          ),
        );

        snackBar.closed.then((onValue) {});
      }
    }
  }

  @override
  void initState() {
    _dbHelper = OrderController();

    _controller.addListener(() {
      /*final text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );*/
    });

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderDetail orderDetail = OrderDetailForm.of(context).orderDetail;
    Order order = OrderDetailForm.of(context).order;
    _controller..text = orderDetail.stockCode;
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
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Stok Kodu"),
                          controller: _controller,
                          //initialValue: orderDetail.stockCode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "İsim Gerekli";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            orderDetail.stockCode = value;
                          },
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.scanner), onPressed: _captureCode)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Stok İsmi"),
                    initialValue: orderDetail.stockName,
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      orderDetail.stockName = value;
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Kaydet $_value"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (orderDetail.id == null) {
                        orderDetail.id = 0;
                        orderDetail.orderId = order.id;
                        orderDetail.status = "";
                        await _dbHelper.addUpdateOrderDetail(orderDetail);
                      } else {
                        await _dbHelper.addUpdateOrderDetail(orderDetail);
                      }
                      FocusScope.of(context).unfocus();
                      resultmsg = "${orderDetail.stockCode} kaydedildi";
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
