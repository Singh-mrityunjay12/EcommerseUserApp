import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../../controller/signup/signup_controller.dart';
import 'term_condition_checkBox.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    print("////////////////////////////////////////////////////SignUpform");

    return Form(
      key: controller.signKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: controller.firstName,
                validator: (value) =>
                    MValidator.validateEmptyText("First Name", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: MTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              const SizedBox(
                width: MSizes.spaceBtwInputFields,
              ),
              Expanded(
                  child: TextFormField(
                controller: controller.lastName,
                validator: (value) =>
                    MValidator.validateEmptyText("Last Name", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: MTexts.lastName, prefixIcon: Icon(Iconsax.user)),
              )),
            ],
          ),
          const SizedBox(
            height: MSizes.spaceBtwInputFields,
          ),
          // UserName
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                MValidator.validateEmptyText("Username", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: MSizes.spaceBtwInputFields,
          ),
          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => MValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: MTexts.email,
            ),
          ),
          const SizedBox(
            height: MSizes.spaceBtwInputFields,
          ),
          //Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => MValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: MTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),

          const SizedBox(
            height: MSizes.spaceBtwInputFields,
          ),
          //Password
          Obx(() => TextFormField(
                controller: controller.password,
                validator: (value) => MValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: MTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    )),
              )),
          const SizedBox(
            height: MSizes.spaceBtwSection,
          ),

          //Term & Condition Checkbox
          TermConditionCheckBox(dark: dark),
          const SizedBox(
            height: MSizes.spaceBtwSection,
          ),
          //Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  controller.signUpCall();
                },
                child: const Text(MTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
