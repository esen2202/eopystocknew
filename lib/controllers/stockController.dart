import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockList extends StatelessWidget {
  final String apiUrl = "http://192.168.2.27:8080/Stocks/getStocks";

  Future<List<dynamic>> fetchStocks() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['Result'];
  }

  String _stockCode(dynamic stock) {
    return "Stok Kodu: " + stock['StockCode'];
  }

  String _amount(dynamic stock) {
    return "Adet: " + stock['Amount'].toString();
  }

  String _status(Map<dynamic, dynamic> stock) {
    return "Durum: " + stock['Status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchStocks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            //leading: CircleAvatar(
                            //  radius: 30,
                            //),
                            //backgroundImage: NetworkImage(
                            //snapshot.data[index]['picture']['large'])),
                            title: Text(_stockCode(snapshot.data[index])),
                            subtitle: Text(_amount(snapshot.data[index])),
                            trailing: Text(_status(snapshot.data[index])),
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
      ),
    );
  }
}
