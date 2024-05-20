import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../persionalization/controller/address_controller.dart';

class MBillingAddressSection extends StatelessWidget {
  const MBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MSectionHeading(
              title: "Shipping Address",
              buttonTitle: "Change",
              onPressed: () =>
                  addressController.selectNewAddressPopup(context)),
          addressController.selectedAddress.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressController.selectedAddress.value.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: MSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: MSizes.spaceBtwItems,
                        ),
                        Text(
                          addressController.selectedAddress.value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: MSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: MSizes.spaceBtwItems,
                        ),
                        Text(
                          "${addressController.selectedAddress.value.street + '${", "}' + addressController.selectedAddress.value.state + '${", "}' + addressController.selectedAddress.value.country + '${" "}' + addressController.selectedAddress.value.postalCode}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
                  ],
                )
              : Text(
                  "Select Address",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
        ],
      );
    });
  }
}
