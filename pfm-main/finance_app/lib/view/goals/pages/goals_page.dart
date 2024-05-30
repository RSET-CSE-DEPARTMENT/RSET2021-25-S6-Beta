import 'dart:async';

import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/goal/goal_list_model.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/view/dashboard/controller/dashboard_controller.dart';
import 'package:finance_app/view/goals/widgets/add_goals_button.dart';
import 'package:finance_app/view/goals/widgets/goal_list_item_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final _dashboardController = DashboardController();

  final goalsRef = FirebaseDatabaseService.goalsRef;
  late StreamSubscription<DatabaseEvent> ref;

  List<GoalListModel> list = [];

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    ref = goalsRef.onValue.listen((event) {
      List<GoalListModel> items = [];
      for (var element in event.snapshot.children) {
        final item = GoalListModel(
            userId: element.child('userId').value.toString(),
            title: element.child('title').value.toString(),
            amount: double.tryParse(element.child('amount').value.toString()));
        items.add(item);
      }
      setState(() {
        list = items
            .where((element) =>
                element.userId == FirebaseAuthService().currentUser?.uid)
            .toList()
            .reversed
            .toList();
      });
    });
  }

  @override
  void dispose() {
    ref.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Goals",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _dashboardController.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const AddGoalsButton(),
      body: list.isEmpty
          ? Center(
              child: Text(
                "You haven't set any goals yet",
                style: semiBoldTextStyle.copyWith(fontSize: 20),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 50),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final model = list[index];
                  return GoalListItemWidget(model: model);
                },
                separatorBuilder: (context, index) => 10.ph,
                itemCount: list.length,
              ),
            ),
    );
  }
}
