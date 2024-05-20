import 'package:e_commerce/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../../controller/login/login_controller.dart';
import '../../signup/signup.dart';

class MLoginForm extends StatelessWidget {
  const MLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MSizes.spaceBtwSection),
          child: Column(
            children: [
              //Email
              TextFormField(
                controller: controller.email,
                validator: (value) => MValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: MTexts.email),
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
                height: MSizes.spaceBtwInputFields / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Rmember me
                  Row(
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                          })),
                      const Text(MTexts.rememberMe)
                    ],
                  ),

                  //Forget password
                  TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPassword());
                      },
                      child: const Text(MTexts.forgetPassword))
                ],
              ),
              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),
              //Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await controller.emailAndPasswordSignIn();
                      // .then(
                      //     (value) => Get.offAll(() => const NavigationMenu())
                      //     );
                    },
                    child: const Text(MTexts.signIn)),
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              //Create Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: const Text(MTexts.createAccount)),
              ),
            ],
          ),
        ));
  }
}
