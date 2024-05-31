import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:finance_app/view/wallet/controller/wallet_controller.dart';
import 'package:finance_app/view/wallet/widgets/add_wallet_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAmountPage extends StatelessWidget {
  static const String route = "/addAmountPageRoute";
  final _controller = WalletController();

  final bool isFromSignUp;

  AddAmountPage({super.key, this.isFromSignUp = false});

  @override
  Widget build(BuildContext context) {
    String title = isFromSignUp == true
        ? "Add Cash To Your Wallet To Continue"
        : "Add Cash To Your Wallet";
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: -10,
        leading: isFromSignUp == false
            ? GestureDetector(
                onTap: () {
                  context.go(HomePage.route);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              )
            : const SizedBox(),
        title: Text(
          "Add Wallet",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            60.ph,
            Center(
              child: Text(
                title,
                style: regularTextStyle,
              ),
            ),
            10.ph,
            Center(
              child: AddWalletTextFieldWidget(controller: _controller.amount),
            ),
            60.ph,
            CommonButton(
              onPressed: () async {
                if (isFromSignUp == true) {
                  await _controller.addCashToWallet();
                } else {
                  await _controller.updateCashInWallet();
                }
              },
              text: "Add To Wallet",
            ),
          ],
        ),
      ),
    );
  }
}
