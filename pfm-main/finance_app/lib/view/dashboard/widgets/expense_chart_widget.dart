import 'dart:math';

import 'package:finance_app/common/extension/string_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/util/amount_util.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseChartWidget extends StatelessWidget {
  final List<IncomeExpenseModel> list;

  const ExpenseChartWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    double jan = 0;
    double feb = 0;
    double mar = 0;
    double apr = 0;
    double may = 0;
    double jun = 0;
    double jul = 0;
    double aug = 0;
    double sep = 0;
    double oct = 0;
    double nov = 0;
    double dec = 0;

    for (var element in list) {
      final dateTime = DateFormat("MMM d, yyyy").parse(element.date ?? "");
      final month = DateFormat("MMM").format(dateTime);
      switch (month.toLowerCase()) {
        case 'jan':
          jan += (element.amount ?? 0);
          break;
        case 'feb':
          feb += (element.amount ?? 0);
          break;
        case 'mar':
          mar += (element.amount ?? 0);
          break;
        case 'apr':
          apr += (element.amount ?? 0);
          break;
        case 'may':
          may += (element.amount ?? 0);
          break;
        case 'jun':
          jun += (element.amount ?? 0);
          break;
        case 'jul':
          jul += (element.amount ?? 0);
          break;
        case 'aug':
          aug += (element.amount ?? 0);
          break;
        case 'sep':
          sep += (element.amount ?? 0);
          break;
        case 'oct':
          oct += (element.amount ?? 0);
          break;
        case 'nov':
          nov += (element.amount ?? 0);
          break;
        case 'dec':
          dec += (element.amount ?? 0);
          break;
      }
    }

    final barGroups = [
      makeGroupData(0, jan),
      makeGroupData(1, feb),
      makeGroupData(2, mar),
      makeGroupData(3, apr),
      makeGroupData(4, may),
      makeGroupData(5, jun),
      makeGroupData(6, jul),
      makeGroupData(7, aug),
      makeGroupData(8, sep),
      makeGroupData(9, oct),
      makeGroupData(10, nov),
      makeGroupData(11, dec),
    ];

    double getHighestYValue() {
      return [
       jan,
       feb,
       mar,
       apr,
       may,
       jun,
       jul,
       aug,
       sep,
       oct,
       nov,
       dec,
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
      height: 250,
      child: BarChart(
        chartData,
        swapAnimationCurve: Curves.easeIn,
        swapAnimationDuration: const Duration(seconds: 1),
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
    final titles = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final Widget text = Text(
      titles[value.toInt()].toTitleCase,
      style: semiBoldTextStyle.copyWith(fontSize: 10),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      angle: 0,
      child: text,
    );
  }
}
