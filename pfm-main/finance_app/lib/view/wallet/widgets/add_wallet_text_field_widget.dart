import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/view/wallet/decoration/add_wallet_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddWalletTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const AddWalletTextFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "\u{20B9}",
            style: semiBoldTextStyle.copyWith(fontSize: 20),
          ),
          10.pw,
          Expanded(
            child: TextField(
              controller: controller,
              style: semiBoldTextStyle.copyWith(fontSize: 20),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: addWalletDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}
