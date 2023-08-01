class TableModel {
  final int tablecapacity;
  final String tablename;

  TableModel({required this.tablecapacity, required this.tablename});

  factory TableModel.fromJson(Map<String, dynamic> json) { // factory constructor to receive json map and converting into TableModel Object
    return TableModel(
        tablecapacity: json['table_capacity'], tablename: json['table_name']);
  }
}
