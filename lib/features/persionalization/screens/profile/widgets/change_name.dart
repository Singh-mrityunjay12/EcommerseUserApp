import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      //Custom AppBar
      appBar: MAppBar(
        showBackArrow: true,
        title: Text(
          "Change Name",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Text(
              "Use real name for easy verification. This name will appear on several pages",
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(
              height: MSizes.spaceBtwSection,
            ),
            // Text field and button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        MValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        MValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: MSizes.spaceBtwSection,
            ),
            //Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('save')),
            )
          ],
        ),
      ),
    );
  }
}
