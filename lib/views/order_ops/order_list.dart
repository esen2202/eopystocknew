import 'package:eopystocknew/controllers/orderController.dart';
import 'package:eopystocknew/models/order.dart';
import 'package:eopystocknew/views/order_ops/order_new.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'order_detail_list.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  OrderController _dbHelper;
  Future<List<Order>> getOrders;
  int orderCount;
  final String deleted = "Deleted";
  final String archived = "Archived";
  final String restore = "";

  @override
  void initState() {
    _dbHelper = OrderController();
    getOrderList();
    super.initState();
  }

  void getOrderList() {
    getOrders = _dbHelper.getOrders();
    getOrders.then((value) {
      orderCount = value.length;
      refresh();
    });
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Listesi Yeni ($orderCount)"),
      ),
      floatingActionButton: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                getOrderList();
              },
              child: Icon(Icons.refresh),
              backgroundColor: Colors.amber,
              heroTag: "Refresh",
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrderPage(
                      order: new Order(),
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
              heroTag: "Add",
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getOrders,
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data.isEmpty) return Text("Sipariş Listeniz Boş...");
          if (snapshot.hasError) return Text("Hata Oluştu...");
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Order order = snapshot.data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddOrderPage(
                        order: order,
                      ),
                    ),
                  ).then(
                    (value) => getOrderList(),
                  );
                },
                child: Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) async {
                    await _dbHelper.changeStatusOrder(order, deleted).then(
                      (value) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${order.name} silindi."),
                            action: SnackBarAction(
                              label: "Geri Al",
                              onPressed: () async {
                                await _dbHelper.changeStatusOrder(
                                    order, restore);

                                getOrderList();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          // order.name.substring(0, 1),
                          (index + 1).toString()),
                    ),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(order.name),
                          Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(2),
                            child: Text(
                              DateFormat('yy-MM-dd (kk:mm)')
                                  .format(order.createdDateTime),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(order.note),
                    trailing: IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailListPage(
                              order: order,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
