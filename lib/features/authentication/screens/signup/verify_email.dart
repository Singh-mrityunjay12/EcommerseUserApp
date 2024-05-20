import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../../controller/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
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
                MTexts.confirmEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              Text(
                email ?? "",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              Text(
                MTexts.confirmEmailSubTitle,
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
                    onPressed: () => controller.checkEmailVerificationStatus(),

                    // Get.to(() => SuccessScreen(
                    //       image: MImage.successIllustration,
                    //       title: MTexts.yourAccountCreatedTitle,
                    //       subTitle: MTexts.yourAccountCreatedSubTitle,
                    //       onPressed: () => Get.to(() => const LoginScreen()),
                    //     ));

                    child: const Text(MTexts.tContinue)),
              ),
              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: const Text(MTexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
