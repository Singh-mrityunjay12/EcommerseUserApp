import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';

import '../../../../../common/widgets/images/m_launched_images.dart';
import '../../../../../common/widgets/products/favourite_icon.dart/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/product_model.dart';

class MProductImageSlider extends StatelessWidget {
  const MProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());

    final images = controller.getAllProductImages(product);
    print("////////////////////////////////////////////////////////////");
    print(images.length);

    final dark = MHelperFunction.isDarkMode(context);
    return MCurvedEdgeWidget(
        child: Container(
      color: dark ? MColors.darkerGrey : MColors.light,
      child: Stack(
        children: [
          //Main large Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(MSizes.productImageRadius * 2),
              child: Center(child: Obx(() {
                final image = controller.selectedProductImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: MColors.primary,
                    ),
                  ),
                );
              })),
            ),
          ),

          //Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: MSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: images.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: MSizes.spaceBtwItems),
                itemBuilder: (_, index) => Obx(() {
                  final imageSelected =
                      controller.selectedProductImage.value == images[index];
                  return MRoundedImages(
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? MColors.dark : MColors.white,
                      border: Border.all(
                          color: imageSelected
                              ? MColors.primary
                              : Colors.transparent),
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      padding: const EdgeInsets.all(MSizes.sm),
                      imageUrl: images[index]);
                }),
              ),
            ),
          ),
          //AppBar Icons
          MAppBar(
            showBackArrow: true,
            actions: [
              MFavoriteIcon(
                productId: product.id,
              )
            ],
          )
        ],
      ),
    ));
  }
}
