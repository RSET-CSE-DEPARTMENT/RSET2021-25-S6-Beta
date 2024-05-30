import 'package:finance_app/view/wallet/pages/add_amount_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddWalletButton extends StatelessWidget {
  const AddWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(AddAmountPage.route);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: const Icon(
          Icons.attach_money_rounded,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
