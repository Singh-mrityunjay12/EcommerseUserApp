import 'package:e_commerce/utils/helpers/heleper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../utils/constants/colors.dart';

class MCartCounterIcon extends StatelessWidget {
  const MCartCounterIcon({
    this.iconColor,
    required this.onPressed,
    this.counterBgColor,
    this.counterTextColor,
    super.key,
  });
  final Color? iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    //Get an instance of the CartController
    final controller = Get.put(CartController());

    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            // onPressed: () {},
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: MColors.black),
              child: Center(
                  child: Obx(() => Text(
                      controller.noOfCartItems.value.toString() != ''
                          ? controller.noOfCartItems.value.toString()
                          : '',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: counterTextColor ??
                              (dark ? MColors.black : MColors.white),
                          fontSizeFactor: 0.8)))),
            ))
      ],
    );
  }
}
