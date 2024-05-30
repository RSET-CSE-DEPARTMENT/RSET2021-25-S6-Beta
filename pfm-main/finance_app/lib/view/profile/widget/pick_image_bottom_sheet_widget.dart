import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/view/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBottomSheetWidget extends StatelessWidget {
  final ProfileController profileController;

  const PickImageBottomSheetWidget({super.key, required this.profileController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.ph,
          Text(
            "Profile Photo",
            style: boldTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
          20.ph,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  profileController.updateImage(context, ImageSource.camera);
                },
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black,
                    ),
                    5.ph,
                    Text("Camera", style: mediumTextStyle)
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  profileController.updateImage(context, ImageSource.gallery);
                },
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.photo,
                      color: Colors.black,
                    ),
                    5.ph,
                    Text("Gallery", style: mediumTextStyle)
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          50.ph,
        ],
      ),
    );
  }
}
