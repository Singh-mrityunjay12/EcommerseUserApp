import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/shop/screens/store/widget/category_tab.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/tabbar.dart';

import '../../../../common/widgets/brands/t_brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../controllers/category_controller.dart';
import '../brand/all_brand.dart';
import '../brand/brand_product.dart';
import '../brand/brands_shimmer.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());

    final categories = CategoryController.insatance.featuredCategories;

    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
            appBar: const MAppBar(
              title: const Text("Store"),
              actions: [
                // MCartCounterIcon(onPressed: () {}
                // )
              ],
            ),
            body: NestedScrollView(
              //Header
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: MHelperFunction.isDarkMode(context)
                        ? MColors.black
                        : MColors.white,
                    expandedHeight: 480,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(MSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          //Search bar
                          const SizedBox(
                            height: MSizes.spaceBtwItems,
                          ),
                          const MSearchContainer(
                            text: "Search in Store",
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                            icon: Iconsax.search_normal,
                          ),
                          const SizedBox(
                            height: MSizes.spaceBtwSection,
                          ),

                          //Featured  Brands

                          MSectionHeading(
                            title: "Featured Brands",
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen()),
                          ),
                          const SizedBox(
                            height: MSizes.spaceBtwItems / 1.5,
                          ),
                          //Brand GRID
                          Obx(() {
                            if (brandController.isLoading.value) {
                              return const MBrandsShimmer();
                            }

                            if (brandController.featureBrands.isEmpty) {
                              return Center(
                                child: Text(
                                  "No Data Found!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: Colors.white),
                                ),
                              );
                            }
                            return MGridLayOut(
                                mainAxisExtend: 88,
                                itemCount: brandController.featureBrands.length,
                                itemBuilder: (_, index) {
                                  final brand =
                                      brandController.featureBrands[index];
                                  return MBrandCard(
                                    showBorder: true,
                                    brand: brand,
                                    onTap: () => Get.to(
                                        () => BrandProducts(brand: brand)),
                                  );
                                });
                          })
                        ],
                      ),
                    ),
                    bottom: MTabBar(
                        tabs: categories
                            .map((category) => Tab(
                                  child: Text(category.name),
                                ))
                            .toList()),
                  ),
                ];
              },
              body: TabBarView(
                children: categories
                    .map((category) => MCategoryTab(category: category))
                    .toList(),
              ),
            )));
  }
}
