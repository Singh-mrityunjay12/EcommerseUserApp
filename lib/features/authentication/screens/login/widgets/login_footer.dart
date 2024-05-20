import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../controller/login/login_controller.dart';

class MLoginFooter extends StatelessWidget {
  const MLoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: MColors.grey,
                ),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                  height: MSizes.iconMd,
                  width: MSizes.iconMd,
                  image: AssetImage(MImage.google)),
            )),
        const SizedBox(width: MSizes.spaceBtwItems),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: MColors.grey,
                ),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                  height: MSizes.iconMd,
                  width: MSizes.iconMd,
                  image: AssetImage(MImage.facebook)),
            )),
      ],
    );
  }
}
