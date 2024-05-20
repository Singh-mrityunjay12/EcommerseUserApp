import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/favorite_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/m_circular_icon.dart';

class MFavoriteIcon extends StatelessWidget {
  const MFavoriteIcon({super.key, required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Obx(() => MCircularIcon(
          icon:
              controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
          color: controller.isFavorite(productId) ? MColors.error : null,
          onPressed: () => controller.toggleFavoriteProduct(productId),
        ));
  }
}
