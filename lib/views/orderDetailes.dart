import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///-> Stateful
class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails(this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

///-> Stateful implement
class _OrderDetailsState extends State<OrderDetails> {
  final OrderController _orderController = OrderController();
  Future<List<OrderDetail>> _orderDetails;
  int deneme = 0;

  ///-> Initialize
  @override
  void initState() {
    super.initState();
    _orderDetails = _orderController.getOrderDetails(widget.order.id);
  }

  ///-> MainWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //-> Appbar
        appBar: AppBar(
          title: Text(widget.order.name),
        ),
        //-> Body
        body: detaylariGetir());
  }

  ///-> BodyWidget
  Widget detaylariGetir() {
    return Container(
      child: FutureBuilder(
        future: _orderDetails,
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderDetail>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(3),
                          child: Container(
                            child: Row(
                              children: [
                                decButton(snapshot.data[index]),
                                Text(
                                  snapshot.data[index].amount.toString(),
                                  style: TextStyle(
                                      fontFamily: "Arial", fontSize: 22),
                                ),
                                incButton(snapshot.data[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(snapshot.data[index].stockCode),
                          subtitle: Text(snapshot.data[index].stockName),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget decButton(OrderDetail data) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          data.amount > 0
              ? new IconButton(
                  icon: new Icon(Icons.remove),
                  onPressed: () => setState(() => data.amount--),
                )
              : new Container(),
        ]);
  }

  Widget incButton(OrderDetail data) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          data.amount < 100
              ? new IconButton(
                  icon: new Icon(
                    Icons.add,
                    size: 32,
                  ),
                  onPressed: () => setState(() => data.amount++),
                )
              : new Container(),
        ]);
  }
}
