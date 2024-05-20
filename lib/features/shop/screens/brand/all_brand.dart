import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/t_brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand_controller.dart';
import 'brand_product.dart';
import 'brands_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Brand"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              const MSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              //Brands
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
                    itemCount: brandController.allBrands.length,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return MBrandCard(
                        showBorder: true,
                        brand: brand,
                        onTap: () => Get.to(() => BrandProducts(
                              brand: brand,
                            )),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
