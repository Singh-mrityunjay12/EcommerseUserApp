import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/carts/add_remove_button.dart';
import '../../../../../common/widgets/products/carts/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class MCartItem1 extends StatelessWidget {
  const MCartItem1({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(
            height: MSizes.spaceBtwSection,
          ),
          itemCount: controller.cartItems.length,
          itemBuilder: (_, index) => Obx(() {
            final item = controller.cartItems[index];
            return Column(
              children: [
                MCartItem(
                  cartItem: item,
                ),
                if (showAddRemoveButtons)
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //extra space
                          const SizedBox(
                            width: 70,
                          ),
                          //Add Remove Buttons
                          MProductQualityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () => controller.addOneToCart(item),
                            remove: () => controller.removeOneFromCart(item),
                          ),
                        ],
                      ),
                      //Product Total Price
                      MProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1))
                    ],
                  )
              ],
            );
          }),
        ));
  }
}
