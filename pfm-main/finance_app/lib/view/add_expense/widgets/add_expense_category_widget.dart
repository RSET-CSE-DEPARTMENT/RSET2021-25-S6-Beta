import 'package:finance_app/view/add_expense/controller/add_expense_controller.dart';
import 'package:finance_app/view/add_expense/widgets/add_expense_category_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpenseCategoryWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onTap;

  const AddExpenseCategoryWidget(
      {super.key, required this.selectedCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width/1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1/0.30
      ),
      itemBuilder: (context, index) => AddExpenseCategoryTile(
        onTap: onTap,
        category: categories[index],
        selectedCategory: selectedCategory,
      ),
    );
  }
}
