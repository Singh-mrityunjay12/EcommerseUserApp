import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../../controller/forget_password/forget_password_controller.dart';
import '../login/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                //Images
                Image(
                  image: const AssetImage(MImage.deliveredEmailIllustration),
                  width: MHelperFunction.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwSection,
                ),
                //Title & SubTitle
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),

                Text(
                  MTexts.changeYourSubPasswordTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwSection,
                ),
                //Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(const LoginScreen()),
                      child: const Text(MTexts.done)),
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => ForgetPasswordController.instance
                          .resendPasswordResetEmail(email),
                      child: const Text(MTexts.resetEmail)),
                )
              ],
            )),
      ),
    );
  }
}
