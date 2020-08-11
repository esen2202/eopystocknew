import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/models/orderDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'orderDetailes.dart';

class OrderList extends StatelessWidget {
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Listesi2'),
      ),
      body: FutureBuilder(
        future: _orderController.getOrderList(),
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
