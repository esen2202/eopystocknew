class StockBarcode {
  int id;
  String barcode;
  String stockCode;
  String detail;

  StockBarcode({
    this.id,
    this.barcode,
    this.stockCode,
    this.detail,
  });

  StockBarcode.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    barcode = json['Barcode'];
    stockCode = json['StockCode'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() => {
        'Id': this.id != null ? this.id : 0,
        'Barcode': this.barcode != null ? this.barcode : "",
        'StockCode': this.stockCode != null ? this.stockCode : "",
        'Detail': this.detail != null ? this.detail : "",
      };
}
