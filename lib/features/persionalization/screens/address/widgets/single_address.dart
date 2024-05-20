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
                right: 5,
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
              )
            ],
          ),
        ),
      );
    });
  }
}
