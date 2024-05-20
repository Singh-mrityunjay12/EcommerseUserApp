import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/images/t_circular_image.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class MProductMetaData extends StatelessWidget {
  const MProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = MHelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Price & Sale Price

        Row(
          children: [
            //Sale Tag
            MRoundedContainer(
              // height: 25,
              // width: 40,
              radius: MSizes.sm,
              backgroundColor: MColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: MSizes.sm, vertical: MSizes.xs),
              child: Center(
                child: Text(
                  '$salePercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: MColors.black),
                ),
              ),
            ),
            const SizedBox(
              width: MSizes.spaceBtwItems,
            ),

            //price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(
                width: MSizes.spaceBtwItems,
              ),
            MProductPriceText(
              price: controller.getProductPrice(product),
              inLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: MSizes.spaceBtwItems / 2,
        ),
        //Title
        MProductTitleText(title: product.title),
        const SizedBox(
          height: MSizes.spaceBtwItems / 2,
        ),

        //Stock Status
        Row(
          children: [
            const MProductTitleText(title: "Status "),
            Text(controller.getProductStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(
          height: MSizes.spaceBtwItems / 2,
        ),

        //Brand
        Row(
          children: [
            MCircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overLayColor: MHelperFunction.isDarkMode(context)
                  ? MColors.white
                  : MColors.black,
            ),
            const SizedBox(
              width: MSizes.spaceBtwItems / 2,
            ),
            MBrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              textColor: dark ? MColors.white : MColors.black,
              brandTextSizes: TextSizes.medium,
            ),
          ],
        ),
        const SizedBox(
          height: MSizes.spaceBtwItems,
        )
      ],
    );
  }
}
