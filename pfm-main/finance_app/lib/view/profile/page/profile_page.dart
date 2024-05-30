import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_button.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/view/dashboard/controller/dashboard_controller.dart';
import 'package:finance_app/view/profile/controller/profile_controller.dart';
import 'package:finance_app/view/profile/widget/circular_image_widget.dart';
import 'package:finance_app/view/profile/widget/pick_image_bottom_sheet_widget.dart';
import 'package:finance_app/view/profile/widget/title_value_pair_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _dashboardController = DashboardController();

  final _profileController = ProfileController();

  User? user = FirebaseAuthService().currentUser;

  bool _isEdit = false;

  onSuccess() {
    setState(() {
      user = FirebaseAuthService().currentUser;
    });
    AppScaffoldManager.getAppScaffoldManager().hideLoader();
  }

  onProfileUpdateComplete() {
    setState(() {
      _isEdit = false;
      user = FirebaseAuthService().currentUser;
    });
    AppScaffoldManager.getAppScaffoldManager().hideLoader();
  }

  @override
  void initState() {
    super.initState();
    _profileController.onSuccess = onSuccess;
    _profileController.onProfileUpdateComplete = onProfileUpdateComplete;
    _profileController.name.text = user?.displayName ?? "";
    _profileController.phone.text = user?.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _dashboardController.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ph,
            Center(
              child: CircularImageWidget(
                isEdit: _isEdit,
                imageUrl: user?.photoURL ?? "",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (context) {
                      return PickImageBottomSheetWidget(
                        profileController: _profileController,
                      );
                    },
                  );
                },
              ),
            ),
            40.ph,
            TitleValuePairWidget(
              title: "Name",
              value: user?.displayName ?? "",
              isEdit: _isEdit,
              controller: _profileController.name,
              keyboardType: TextInputType.text,
            ),
            TitleValuePairWidget(
              title: "Email ID",
              value: user?.email ?? "",
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
            ),
            40.ph,
            CommonButton(
              onPressed: () {
                if (!_isEdit) {
                  setState(() {
                    _isEdit = true;
                  });
                } else {
                  _profileController.updateProfile();
                }
              },
              text: _isEdit ? "Save Profile" : "Edit Profile",
            ),
            10.ph,
            if (_isEdit)
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isEdit = false;
                  });
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
                  child: Text(
                    "Cancel",
                    style: mediumTextStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
