import 'package:e_commerce/features/shop/screens/product_all/product_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_category.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MPrimaryHeaderContainer(
              child: Column(
                children: [
                  //AppBar
                  MHomeAppBar(),
                  SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  //SearchBar
                  MSearchContainer(
                    text: 'Search in Store',
                    icon: Iconsax.search_normal,
                  ),
                  SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  //Categories
                  Padding(
                    padding: EdgeInsets.only(left: MSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Heading
                        MSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: MColors.light,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  //Categories
                  MHomeCategories(),
                  SizedBox(
                    height: MSizes.spaceBtwItems,
                  )
                ],
              ),
            ),
            //Body
            const Padding(
              padding: EdgeInsets.all(MSizes.defaultSpace),
              child: MPromoSlider(),
            ),
            //Heading
            Padding(
              padding: const EdgeInsets.all(MSizes.spaceBtwProduct),
              child: MSectionHeading(
                title: "Popular Products",
                showActionButton: true,
                onPressed: () => Get.to(() => AllProduct(
                      title: "Popular Products",
                      // query: FirebaseFirestore.instance
                      //     .collection("Products")
                      //     .where('IsFeatured', isEqualTo: true)
                      //     .limit(6),
                      futureMethod: controller.fetchAllFeaturedProducts(),
                    )),
                textColor: MColors.dark,
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const MVerticalProductShimmer();
              }

              if (controller.featuredProducts.isEmpty) {
                return Center(
                  child: Text(
                    "No Data Found!",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MGridLayOut(
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (_, index) => MProductCardVertical(
                    product: controller.featuredProducts[index],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
