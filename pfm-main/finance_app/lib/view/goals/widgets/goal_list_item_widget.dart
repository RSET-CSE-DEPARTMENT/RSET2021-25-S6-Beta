import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/goal/goal_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoalListItemWidget extends StatelessWidget {
  final GoalListModel model;

  const GoalListItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/goal.svg",
                height: 25,
                width: 25,
                colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
              ),
            ),
            10.pw,
            Expanded(child: Text(model.title ?? "", style: semiBoldTextStyle)),
            10.pw,
            Text(
              "\u{20B9}${model.amount ?? 0}",
              style: semiBoldTextStyle.copyWith(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
