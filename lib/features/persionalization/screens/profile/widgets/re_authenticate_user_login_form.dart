import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Re-Authenticate User"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Form(
                key: controller.reAuthFormKey,
                child: Column(
                  children: [
                    //Email
                    TextFormField(
                      controller: controller.verifyEmail,
                      validator: MValidator.validateEmail,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Iconsax.direct_right,
                          ),
                          labelText: MTexts.email),
                    ),
                    const SizedBox(
                      height: MSizes.inputFieldRadius,
                    ),
                    //Password
                    Obx(() => TextFormField(
                          controller: controller.verifyPassword,
                          validator: (value) =>
                              MValidator.validateEmptyText('Password', value),
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
                    //Verify button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              controller.reAuthenticateEmailAndPasswordUser(),
                          child: const Text("Verify")),
                    )
                  ],
                ))),
      ),
    );
  }
}
