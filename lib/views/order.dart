import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Listesi'),
      ),
      body: FutureBuilder(
        future: _orderController.getOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].note),
                          trailing: Text(DateFormat('yyyy-MM-dd – kk:mm')
                              .format(snapshot.data[index].createdDateTime)),
                          leading: CircleAvatar(
                              child: Text(
                                  snapshot.data[index].name.substring(0, 1))),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetails(snapshot.data[index])));
                          },
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails(this.order);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final OrderController _orderController = OrderController();
  Future<List<OrderDetail>> _orderDetails;
  int deneme = 0;

  @override
  void initState() {
    super.initState();
    _orderDetails = _orderController.getOrderDetails(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.name),
      ),
      body: Container(
        height: 270.0,
        width: 350.0,
        child: Center(
          child: FutureBuilder(
            future: _orderDetails,
            builder: (BuildContext context,
                AsyncSnapshot<List<OrderDetail>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(snapshot.data[index].amount.toString())
                        ],
                      );
                      /* ListTile(
                        title: new Text(snapshot.data[index].stockCode),
                        trailing: new Row(
                          children: <Widget>[
                            //snapshot.data[index].amount != 0
                            //   ? new IconButton(
                            //       icon: new Icon(Icons.remove),
                            //       onPressed: () => setState(
                            //            () => snapshot.data[index].amount--),
                            //      )
                            //    : new Container(),
                            new Text(snapshot.data[index].amount.toString()),
                            //new IconButton(
                            //    icon: new Icon(Icons.add),
                            //   onPressed: () => setState(
                            //       () => snapshot.data[index].amount++))
                          ],
                        ),
                      );*/
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
