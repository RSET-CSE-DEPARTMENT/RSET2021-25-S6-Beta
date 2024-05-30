import 'package:floor/floor.dart';

@entity
class IncomeExpenseModel {
  @primaryKey
  int? id;
  String? userId;
  String? title;
  String? description;
  double? amount;
  String? date;
  String? time;
  String? category;
  String? type;

  IncomeExpenseModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.amount,
    this.date,
    this.time,
    this.category,
    this.type,
  });

  IncomeExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    amount = double.tryParse(json['amount'].toString());
    date = json['date'];
    time = json['time'];
    category = json['category'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['amount'] = amount;
    data['date'] = date;
    data['time'] = time;
    data['category'] = category;
    data['type'] = type;
    return data;
  }
}