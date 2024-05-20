import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllers/product/check_out_controller.dart';

class MBillingPaymentSection extends StatelessWidget {
  const MBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = MHelperFunction.isDarkMode(context);
    return Column(
      children: [
        MSectionHeading(
          title: "Payment Section",
          buttonTitle: "Change",
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(
          height: MSizes.spaceBtwItems / 2,
        ),
        Obx(() => Row(
              children: [
                MRoundedContainer(
                  width: 60,
                  height: 35,
                  backgroundColor: dark ? MColors.light : MColors.white,
                  padding: const EdgeInsets.all(MSizes.sm),
                  child: Image(
                    image: AssetImage(
                      controller.selectedPaymentMethod.value.image,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: MSizes.spaceBtwItems / 2,
                ),
                Text(
                  controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ))
      ],
    );
  }
}
