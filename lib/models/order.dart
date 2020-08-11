class Order {
  int id;
  String name;
  String note;
  DateTime createdDateTime;

  Order({this.id, this.name, this.note, this.createdDateTime});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    note = json['Note'];
    createdDateTime = DateTime.parse(json['CreatedDateTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Note'] = this.note;
    data['CreatedDateTime'] = this.createdDateTime;
    return data;
  }
}
