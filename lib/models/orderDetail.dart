class OrderDetail {
  int id;
  int orderId;
  int sequence;
  String stockCode;
  String stockName;
  int amount;

  OrderDetail(
      {this.id,
      this.orderId,
      this.sequence,
      this.stockCode,
      this.stockName,
      this.amount});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderId = json['OrderId'];
    sequence = json['Sequence'];
    stockCode = json['StockCode'];
    stockName = json['StockName'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['OrderId'] = this.orderId;
    data['Sequence'] = this.sequence;
    data['StockCode'] = this.stockCode;
    data['StockName'] = this.stockName;
    data['Amount'] = this.amount;
    return data;
  }
}
