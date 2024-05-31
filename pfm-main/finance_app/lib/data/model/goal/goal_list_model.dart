class GoalListModel {
  String? userId;
  String? title;
  double? amount;

  GoalListModel({this.userId, this.title, this.amount});

  GoalListModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['title'] = title;
    data['amount'] = amount;
    return data;
  }
}
