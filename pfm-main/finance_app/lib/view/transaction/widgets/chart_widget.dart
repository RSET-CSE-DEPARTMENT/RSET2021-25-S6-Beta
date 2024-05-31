import 'dart:math';

import 'package:finance_app/common/extension/string_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/util/amount_util.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/view/add_expense/controller/add_expense_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final List<IncomeExpenseModel> list;

  const ChartWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    double booksAmount = 0;
    double carAmount = 0;
    double clothesAmount = 0;
    double educationAmount = 0;
    double foodAmount = 0;
    double groceriesAmount = 0;
    double phoneAmount = 0;

    for (var element in list) {
      switch (element.category) {
        case "books":
          booksAmount += (element.amount ?? 0);
          break;
        case "car":
          carAmount += (element.amount ?? 0);
          break;
        case "clothes":
          clothesAmount += (element.amount ?? 0);
          break;
        case "education":
          educationAmount += (element.amount ?? 0);
          break;
        case "food":
          foodAmount += (element.amount ?? 0);
          break;
        case "groceries":
          groceriesAmount += (element.amount ?? 0);
          break;
        case "phone-bill":
          phoneAmount += (element.amount ?? 0);
          break;
      }
    }

    final barGroups = [
      makeGroupData(0, booksAmount),
      makeGroupData(1, carAmount),
      makeGroupData(2, clothesAmount),
      makeGroupData(3, educationAmount),
      makeGroupData(4, foodAmount),
      makeGroupData(5, groceriesAmount),
      makeGroupData(6, phoneAmount),
    ];

    double getHighestYValue() {
      return [
        booksAmount,
        carAmount,
        clothesAmount,
        educationAmount,
        foodAmount,
        groceriesAmount,
        phoneAmount,
      ].reduce(max);
    }

    BarChartData chartData = BarChartData(
      maxY: getHighestYValue() + 400,
      barGroups: barGroups,
      gridData: const FlGridData(show: false),
      titlesData: titlesData(),
      borderData: borderData(),
    );

    return SizedBox(
      height: 200,
      child: BarChart(
        chartData,
        swapAnimationCurve: Curves.easeIn,
        swapAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }

  int getIndexFromCategory(String category) {
    return categories.indexOf(category);
  }

  FlTitlesData titlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 42,
          getTitlesWidget: bottomTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 42,
          getTitlesWidget: leftTitles,
        ),
      ),
    );
  }

  FlBorderData borderData() {
    return FlBorderData(
      border: const Border(
        bottom: BorderSide(color: Colors.grey),
        left: BorderSide(color: Colors.grey),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.blue),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      getAmountString(value),
      style: semiBoldTextStyle.copyWith(fontSize: 10),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      angle: 0,
      child: text,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      categories[value.toInt()].toTitleCase,
      style: boldTextStyle,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      angle: 75,
      child: text,
    );
  }
}
