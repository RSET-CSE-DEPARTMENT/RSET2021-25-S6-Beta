import 'package:floor/floor.dart';

@entity
class UserModel {
  @primaryKey
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? photo;
  double? cashInWallet;
  double? totalIncome;
  double? totalExpense;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.photo,
      this.cashInWallet,
      this.totalIncome,
      this.totalExpense});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
    cashInWallet = json['cashInWallet'];
    totalExpense = json['totalExpense'];
    totalIncome = json['totalIncome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['photo'] = photo;
    data['cashInWallet'] = cashInWallet;
    data['totalExpense'] = totalExpense;
    data['totalIncome'] = totalIncome;
    return data;
  }
}
