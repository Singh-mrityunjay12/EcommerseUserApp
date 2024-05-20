import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loadders/animation_loadder.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';
import 'widgets/cart_item1.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: MAppBar(
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      //Checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(() =>
                      Text("Checkout \$${controller.totalCartPrice.value}"))),
            ),
      body: Obx(() {
        //Nothing Found Widget
        final emptyWidget = MAnimationLoaderWidget(
          text: 'Whoops! Cart is EMPTY.',
          animation: MImage.cartAnimation,
          showAction: true,
          actionText: 'Let\s fill it',
          onActionPressed: () => Get.off(() => NavigationMenu()),
        );

        return controller.cartItems.isEmpty
            ? emptyWidget
            : const SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(MSizes.defaultSpace),
                    child: MCartItem1()),
              );
      }),
    );
  }
}
