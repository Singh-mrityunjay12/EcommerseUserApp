import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/m_launched_images.dart';
import '../../../../../common/widgets/shimmer/loadingIndicator.dart';
import '../../../../../utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banner_controller.dart';

class MPromoSlider extends StatelessWidget {
  const MPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      //Loader
      if (controller.isLoading.value) {
        return const MShimmerEffect(width: double.infinity, height: 190);
      }
      //No Data found
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text("No Data Found"),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map((banners) => MRoundedImages(
                        imageUrl: banners.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banners.targetScreen),
                      ))
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
            ),
            const SizedBox(
              height: MSizes.spaceBtwItems,
            ),
            Center(
              child: Obx(() => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        MCircularContainer(
                          width: 20,
                          height: 4,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? MColors.primary
                                  : MColors.grey,
                        )
                    ],
                  )),
            )
          ],
        );
      }
    });
  }
}
