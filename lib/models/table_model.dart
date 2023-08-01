class TableModel {
  final int tablecapacity;
  final String tablename;

  TableModel({required this.tablecapacity, required this.tablename});

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
        tablecapacity: json['table_capacity'], tablename: json['table_name']);
  }
}
