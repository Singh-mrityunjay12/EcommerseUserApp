import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllers/product/check_out_controller.dart';
import '../../../models/payment_method_model.dart';

class MPaymentTile extends StatelessWidget {
  const MPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: MRoundedContainer(
        height: 40,
        width: 60,
        backgroundColor:
            MHelperFunction.isDarkMode(context) ? MColors.light : MColors.white,
        padding: const EdgeInsets.all(MSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
