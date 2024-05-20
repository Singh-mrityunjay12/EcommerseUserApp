import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/m_circular_icon.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/loadders/animation_loadder.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favorite_controller.dart';
import '../home/home_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Scaffold(
      appBar: MAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          MCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.spaceBtwProduct),

            //Product Grid
            child: Obx(() => FutureBuilder(
                future: controller.favoriteProduct(),
                builder: (context, snapshot) {
                  //Nothing Widget Found
                  final emptyWidget = MAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: MImage.pencilGif3,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () =>
                        Get.offAll(() => const NavigationMenu()),
                  );

                  const loader = MVerticalProductShimmer(
                    itemCount: 6,
                  );
                  final widget = MCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  return MGridLayOut(
                      itemCount: products.length,
                      itemBuilder: (_, index) => MProductCardVertical(
                            product: products[index],
                          ));
                }))),
      ),
    );
  }
}
