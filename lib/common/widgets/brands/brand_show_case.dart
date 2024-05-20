import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/screens/brand/brand_product.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../shimmer/loadingIndicator.dart';
import 't_brand_card.dart';

class MBrandShowcase extends StatelessWidget {
  const MBrandShowcase({super.key, required this.images, required this.brand});

  final BrandModel brand;
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: MRoundedContainer(
        height: 230,
        showBorder: true,
        borderColor: MColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(MSizes.md),
        margin: const EdgeInsets.only(
          bottom: MSizes.spaceBtwItems,
        ),
        child: Column(
          children: [
            //Brand with Product Count

            MBrandCard(
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(
              height: MSizes.spaceBtwItems,
            ),
            //Brand Top 3 Product Images
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String images, context) {
  return Flexible(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MRoundedContainer(
          height: 110,
          width: 90,
          backgroundColor: MHelperFunction.isDarkMode(context)
              ? MColors.darkerGrey
              : MColors.light,
          margin: const EdgeInsets.only(right: MSizes.sm, left: MSizes.sm),
          padding: const EdgeInsets.all(MSizes.md),
          child: CachedNetworkImage(
            imageUrl: images,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const MShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    ),
  );
}
