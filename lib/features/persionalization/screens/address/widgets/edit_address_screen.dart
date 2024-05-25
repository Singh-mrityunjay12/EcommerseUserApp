import 'package:e_commerce/data/repositories_authentication/authentication/authentication_repository.dart';
import 'package:e_commerce/features/persionalization/model/adress/adress_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/edit_address_controller.dart';

class AddNewEditAddressScreen extends StatelessWidget {
  const AddNewEditAddressScreen({super.key, required this.addressModel});

  final AddressModel addressModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressEditController());
    final dark = MHelperFunction.isDarkMode(context);

    print('////////////////////////////////${addressModel.id}');

    print(
        '///////////////////////////${AuthenticationRepository.instance.authUser!.uid}');
    return Scaffold(
      appBar: const MAppBar(
        showBackArrow: true,
        title: Text("Edit Address...."),
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
                    controller: controller.name..text = addressModel.name,
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
                    controller: controller.phoneNumber
                      ..text = addressModel.phoneNumber,
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
                          controller: controller.street
                            ..text = addressModel.street,
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
                          controller: controller.postalCode
                            ..text = addressModel.postalCode,
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
                          controller: controller.city..text = addressModel.city,
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
                          controller: controller.state
                            ..text = addressModel.state,
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
                    controller: controller.country..text = addressModel.country,
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
                          controller.addNewAddresses(addressModel.id);
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
