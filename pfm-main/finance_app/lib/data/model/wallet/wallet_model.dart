import 'package:floor/floor.dart';

@entity
class WalletModel {
  @primaryKey
  String? uid;
  double? amount;

  WalletModel({this.uid, this.amount});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
