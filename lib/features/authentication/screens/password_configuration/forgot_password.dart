import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../controller/forget_password/forget_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: MSizes.defaultSpace,
            ),
            //Heading
            //Title & SubTitle
            Text(
              MTexts.forgetPassword,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: MSizes.spaceBtwItems,
            ),

            Text(
              MTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: MSizes.spaceBtwSection * 2,
            ),

            //Text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: (value) => MValidator.validateEmail(value),
                decoration: const InputDecoration(
                    labelText: MTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),

            const SizedBox(
              height: MSizes.spaceBtwSection,
            ),
            //Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(MTexts.submit)),
            ),
          ],
        ),
      ),
    );
  }
}
