import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/view/goals/controller/goals_controller.dart';
import 'package:finance_app/view/goals/widgets/add_goal_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddGoalsPage extends StatelessWidget {
  static const String route = "/addGoalsRoute";
  final _controller = GoalsController();

  AddGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add New Goal",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              20.ph,
              AddGoalTextFieldWidget(
                controller: _controller.title,
                hintText: "Title",
                validator: _controller.titleValidator,
              ),
              20.ph,
              AddGoalTextFieldWidget(
                controller: _controller.amount,
                keyboardType: TextInputType.number,
                hintText: "Amount",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                isAmount: true,
                validator: _controller.amountValidator,
              ),
              30.ph,
              CommonButton(
                onPressed: () async {
                  await _controller.addNewGoal();
                },
                text: "Add Goal",
              ),
              50.ph
            ],
          ),
        ),
      ),
    );
  }
}
