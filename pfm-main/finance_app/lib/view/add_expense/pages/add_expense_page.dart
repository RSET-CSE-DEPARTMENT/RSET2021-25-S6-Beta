import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/view/add_expense/controller/add_expense_controller.dart';
import 'package:finance_app/view/add_expense/widgets/add_expense_category_widget.dart';
import 'package:finance_app/view/add_expense/widgets/add_expense_date_time_widget.dart';
import 'package:finance_app/view/add_expense/widgets/add_expense_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AddExpensePage extends StatefulWidget {
  static const String route = "/addExpensePageRoute";

  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _controller = AddExpenseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Expense",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ph,
              AddExpenseTextFieldWidget(
                controller: _controller.title,
                hintText: "Title",
                validator: _controller.titleValidator,
              ),
              20.ph,
              AddExpenseTextFieldWidget(
                controller: _controller.description,
                textCapitalization: TextCapitalization.sentences,
                hintText: "Description",
                minLines: 1,
                maxLines: 10,
              ),
              20.ph,
              AddExpenseTextFieldWidget(
                controller: _controller.amount,
                keyboardType: TextInputType.number,
                hintText: "Amount",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                isAmount: true,
                validator: _controller.amountValidator,
              ),
              20.ph,
              AddExpenseDateTimeWidget(
                date: _controller.date,
                time: _controller.time,
              ),
              20.ph,
              Text(
                "Select Category",
                style: semiBoldTextStyle.copyWith(fontSize: 18),
              ),
              20.ph,
              AddExpenseCategoryWidget(
                selectedCategory: _controller.selectedCategory,
                onTap: (String value) {
                  setState(() {
                    _controller.setSelectedCategory(value);
                  });
                },
              ),
              50.ph,
              GestureDetector(
                onTap: () async {
                  _launchGooglePay();
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.black45)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/gpay.png",
                        width: 30,
                        height: 30,
                      ),
                      10.pw,
                      Text(
                        "Make Transaction With Google Pay",
                        style: mediumTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              20.ph,
              CommonButton(
                onPressed: () async {
                  await _controller.addExpenseToDB();
                },
                text: "Save Transaction",
              ),
              50.ph
            ],
          ),
        ),
      ),
    );
  }

  _launchGooglePay() async {
    const String googlePayUrl =
        'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_US&gl=US';
    final uri = Uri.parse(googlePayUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $googlePayUrl';
    }
  }
}
