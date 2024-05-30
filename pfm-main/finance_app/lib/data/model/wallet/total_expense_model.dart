import 'package:floor/floor.dart';

@entity
class TotalExpenseModel {
  @primaryKey
  String? uid;
  double? amount;

  TotalExpenseModel({this.uid, this.amount});

  TotalExpenseModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['amount'] = amount;
    return data;
  }
}