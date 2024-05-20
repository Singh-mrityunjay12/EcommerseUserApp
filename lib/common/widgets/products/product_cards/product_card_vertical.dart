import 'package:e_commerce/features/shop/screens/product_details/product_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

import '../../images/m_launched_images.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';
import '../favourite_icon.dart/favourite_icon.dart';
import 'add_to_cart_button.dart';

class MProductCardVertical extends StatelessWidget {
  const MProductCardVertical({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final salePercentage = productController.calculateSalePercentage(
        product!.price, product!.salePrice);
    final dark = MHelperFunction.isDarkMode(context);

    //Container with side paddings,color,edges,radius and shadow.

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(
            product: product!,
          )),
      child: Container(
        width: 210,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            // boxShadow: [MShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(MSizes.productImageRadius),
            color: dark ? MColors.darkerGrey : MColors.lightContainer),
        child: Column(
          children: [
            //Thumbnail,Wishlist button,Discount

            MRoundedContainer(
              height: 165,
              padding: const EdgeInsets.all(MSizes.sm),
              backgroundColor: dark ? MColors.dark : MColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image

                  Center(
                    child: MRoundedImages(
                      imageUrl: product!.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  //Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: MRoundedContainer(
                        radius: MSizes.sm,
                        backgroundColor: MColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: MSizes.sm, vertical: MSizes.xs),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: MColors.black),
                        ),
                      ),
                    ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: MFavoriteIcon(
                        productId: product!.id,
                      ))

                  //Favorite Icon Button
                ],
              ),
            ),

            const SizedBox(
              height: MSizes.spaceBtwItems / 2,
            ),
            //Details

            Padding(
              padding: const EdgeInsets.only(left: MSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MProductTitleText(
                    title: product!.title,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwItems / 2,
                  ),
                  MBrandTitleWithVerifiedIcon(title: product!.brand!.name)
                ],
              ),
            ),
            //Add Spacer() here to keep the height of each Box same in case 1 or 2 Lines of Headings
            //Use spacer to utilized all the space to set the price and the cart button at the bottom
            //This usually happens when product title is in single line or 2 lines(max)
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Price
                Flexible(
                  child: Column(
                    children: [
                      if (product!.productType ==
                              ProductType1.single.toString() &&
                          product!.salePrice > 0)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: MSizes.sm, bottom: MSizes.sm),
                          child: Text(
                            product!.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      //Price,Show sale price as main price if sale exist.

                      Padding(
                        padding: const EdgeInsets.only(left: MSizes.sm),
                        child: MProductPriceText(
                            price: productController.getProductPrice(product!)),
                      ),
                    ],
                  ),
                ),
                //Add to Cart Button
                ProductCardAddToCartButton(
                  product: product!,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
