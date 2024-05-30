import 'package:floor/floor.dart';

@entity
class TotalIncomeModel {
  @primaryKey
  String? uid;
  double? amount;

  TotalIncomeModel({this.uid, this.amount});

  TotalIncomeModel.fromJson(Map<String, dynamic> json) {
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