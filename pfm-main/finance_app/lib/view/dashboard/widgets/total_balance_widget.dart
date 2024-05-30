import 'package:finance_app/common/widget/common_container.dart';
import 'package:finance_app/common/widget/title_value_pair_widget.dart';
import 'package:finance_app/view/dashboard//controller/dashboard_controller.dart';
import 'package:flutter/material.dart';

class TotalBalanceWidget extends StatefulWidget {
  const TotalBalanceWidget({super.key});

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  final _controller = DashboardController();
  double _amount = 0.0;

  @override
  void initState() {
    super.initState();
    setAmount();
  }

  setAmount() async {
    _amount = await _controller.getCashInWallet() ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: TitleValuePairWidget(
          title: "Total Balance",
          value: "\u{20B9}$_amount",
        ),
      ),
    );
  }
}
