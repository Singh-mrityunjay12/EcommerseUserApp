import 'package:e_commerce/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:flutter/material.dart';

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

class MProductCardHorizontal extends StatelessWidget {
  const MProductCardHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          // boxShadow: [MShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MSizes.productImageRadius),
          color: dark ? MColors.darkerGrey : MColors.softGrey),
      child: Row(children: [
        //Thumbnail
        MRoundedContainer(
          height: 120,
          padding: const EdgeInsets.all(MSizes.sm),
          backgroundColor: dark ? MColors.dark : MColors.light,
          child: Stack(
            children: [
              //Thumbnail Image
              SizedBox(
                height: 120,
                width: 120,
                child: MRoundedImages(
                  imageUrl: product.thumbnail,
                  applyImageRadius: true,
                  isNetworkImage: true,
                ),
              ),
              //Sale Tag
              if (salePercentage != null)
                Positioned(
                  top: 10,
                  child: MRoundedContainer(
                    radius: MSizes.sm,
                    backgroundColor: MColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: MSizes.sm, vertical: MSizes.xs),
                    child: Text(
                      "$salePercentage%",
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
                    productId: product.id,
                  ))
            ],
          ),
        ),

        //Details & Add to Cart, & Pricing

        SizedBox(
          width: 172,
          child: Padding(
            padding: const EdgeInsets.only(top: MSizes.sm, left: MSizes.sm),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MBrandTitleWithVerifiedIcon(title: product.brand!.name),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Price
                    Flexible(
                      child: Column(
                        children: [
                          if (product.productType ==
                                  ProductType1.single.toString() &&
                              product.salePrice > 0)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: MSizes.sm, bottom: MSizes.sm),
                              child: Text(
                                product.price.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                            ),

                          //Price,Show sale price as main price if sale exist.

                          Padding(
                            padding: const EdgeInsets.only(left: MSizes.sm),
                            child: MProductPriceText(
                                price: controller.getProductPrice(product)),
                          ),
                        ],
                      ),
                    ),

                    //Add to Cart button
                    ProductCardAddToCartButton(
                      product: product,
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
