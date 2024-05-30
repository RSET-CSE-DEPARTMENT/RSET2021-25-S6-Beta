import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/extension/string_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

class AddExpenseCategoryTile extends StatelessWidget {
  final String category, selectedCategory;
  final Function(String) onTap;

  const AddExpenseCategoryTile({
    super.key,
    required this.category,
    required this.selectedCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: category == selectedCategory ? Colors.blue : Colors.white,
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/categories_icons/$category.png",
              height: 20,
              width: 20,
            ),
            10.pw,
            Expanded(child: Text(category.toTitleCase, style: mediumTextStyle)),
          ],
        ),
      ),
    );
  }
}
