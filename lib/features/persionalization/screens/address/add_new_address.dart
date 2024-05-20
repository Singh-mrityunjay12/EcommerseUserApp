import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    final dark = MHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: const MAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Form(
              key: controller.addressFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: controller.name,
                    validator: (value) =>
                        MValidator.validateEmptyText('Name', value),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.user),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: dark ? MColors.light : MColors.dark)),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: MValidator.validatePhoneNumber,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.mobile),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                            color: dark ? MColors.light : MColors.dark)),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.street,
                          validator: (value) =>
                              MValidator.validateEmptyText('Street', value),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.building_31),
                              labelText: "Street",
                              labelStyle: TextStyle(
                                  color: dark ? MColors.light : MColors.dark)),
                        ),
                      ),
                      const SizedBox(
                        width: MSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) => MValidator.validateEmptyText(
                              'Postal Code', value),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.code),
                              labelText: "Postal Code",
                              labelStyle: TextStyle(
                                  color: dark ? MColors.light : MColors.dark)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.city,
                          validator: (value) =>
                              MValidator.validateEmptyText('City', value),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.building),
                              labelText: "City",
                              labelStyle: TextStyle(
                                  color: dark ? MColors.light : MColors.dark)),
                        ),
                      ),
                      const SizedBox(
                        width: MSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.state,
                          validator: (value) =>
                              MValidator.validateEmptyText('State', value),
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.activity),
                              labelText: "State",
                              labelStyle: TextStyle(
                                  color: dark ? MColors.light : MColors.dark)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.country,
                    validator: (value) =>
                        MValidator.validateEmptyText('Country', value),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.global),
                        labelText: "Country",
                        labelStyle: TextStyle(
                            color: dark ? MColors.light : MColors.dark)),
                  ),
                  const SizedBox(
                    height: MSizes.defaultSpace,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.addNewAddresses();
                        },
                        child: const Text("save")),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
