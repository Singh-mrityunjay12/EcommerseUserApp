import 'package:e_commerce/data/repositories_authentication/authentication/authentication_repository.dart';
import 'package:e_commerce/features/persionalization/screens/address/widgets/edit_address_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controller/address_controller.dart';
import '../../../model/adress/adress_model.dart';

class MSingleAddresses extends StatelessWidget {
  const MSingleAddresses(
      {super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    final dark = MHelperFunction.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: MRoundedContainer(
          padding: const EdgeInsets.all(MSizes.md),
          width: double.infinity,
          height: 200,
          showBorder: true,
          backgroundColor: selectedAddress
              ? MColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? MColors.darkerGrey
                  : MColors.grey,
          margin: const EdgeInsets.only(bottom: MSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 0,
                child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? MColors.light
                            : MColors.dark.withOpacity(0.6)
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: MSizes.sm / 2,
                  ),
                  Text(address.formatePhoneNo,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: MSizes.sm / 2,
                  )
                ],
              ),
              Positioned(
                right: -12,
                top: 55,
                child: IconButton(
                    onPressed: () async {
                      await Get.defaultDialog(
                          // cancelTextColor: Colors.white,
                          // backgroundColor: Colors.teal,
                          title: 'Delete Address',
                          content: const Text(
                              'Are you sure you want to delete Address?'),
                          textCancel: 'Cancel',
                          textConfirm: 'Delete',
                          contentPadding: const EdgeInsets.all(10),
                          confirmTextColor: Colors.white,
                          onCancel: () {},
                          onConfirm: () {
                            Get.back(); //Close the Dialog

                            controller.deleteImageFromFireStore1(
                                AuthenticationRepository.instance.authUser!.uid,
                                address.id);
                          });
                    },
                    icon: Icon(selectedAddress ? Iconsax.trash : null,
                        color: selectedAddress
                            ? dark
                                ? MColors.light
                                : MColors.dark.withOpacity(0.6)
                            : null)),
              ),
              Positioned(
                right: -12,
                top: 120,
                child: IconButton(
                    onPressed: () {
                      Get.to(
                          () => AddNewEditAddressScreen(addressModel: address));
                    },
                    icon: Icon(selectedAddress ? Iconsax.edit : null,
                        color: selectedAddress
                            ? dark
                                ? MColors.light
                                : MColors.dark.withOpacity(0.6)
                            : null)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
