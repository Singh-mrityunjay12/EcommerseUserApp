import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_details.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    required this.product,
    super.key,
  });

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(onTap: () {
      //If the product have variations then show the product details for variations selections
      //Else add product to the cart

      if (product.productType == ProductType.single.toString()) {
        final cartItem = controller.convertToCartItem(product, 1);
        controller.addOneToCart(cartItem);
      } else {
        Get.to(() => ProductDetailsScreen(
              product: product,
            ));
      }
    }, child: Obx(() {
      final productQuantityInCart =
          controller.getProductQuantityInCart(product.id);

      return Container(
        decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? MColors.primary : MColors.dark,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MSizes.cardRadiusMd),
                bottomRight: Radius.circular(MSizes.productImageRadius))),
        child: SizedBox(
          width: MSizes.iconLg * 1.2,
          height: MSizes.iconLg * 1.2,
          child: Center(
            child: productQuantityInCart > 0
                ? Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: Colors.white),
                  )
                : const Icon(
                    Iconsax.add,
                    color: MColors.white,
                  ),
          ),
        ),
      );
    }));
  }
}
