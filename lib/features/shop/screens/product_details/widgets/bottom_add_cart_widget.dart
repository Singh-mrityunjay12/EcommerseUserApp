import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/m_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../models/product_model.dart';

class MBottomAddToCart extends StatelessWidget {
  const MBottomAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = MHelperFunction.isDarkMode(context);
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MSizes.defaultSpace, vertical: MSizes.defaultSpace / 2),
        decoration: BoxDecoration(
            color: dark ? MColors.darkerGrey : MColors.light,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(MSizes.cardRadiusLg),
              topRight: Radius.circular(MSizes.cardRadiusLg),
            )),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: MColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: MColors.white,
                    onPressed: () => controller.productQuantityInCart.value < 1
                        ? null
                        : controller.productQuantityInCart.value -= 1,
                  ),
                  const SizedBox(
                    width: MSizes.spaceBtwItems,
                  ),
                  Text(
                    controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: MSizes.spaceBtwItems,
                  ),
                  MCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: MColors.black,
                    width: 40,
                    height: 40,
                    color: MColors.white,
                    onPressed: () =>
                        controller.productQuantityInCart.value += 1,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: controller.productQuantityInCart.value < 1
                      ? null
                      : () => controller.addToCart(product),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(MSizes.md),
                    backgroundColor: MColors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text("Add to Cart"))
            ],
          ),
        ));
  }
}
