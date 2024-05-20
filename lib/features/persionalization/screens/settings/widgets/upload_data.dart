import 'package:e_commerce/common/widgets/loadders/spinkit_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

import '../../../../../common/widgets/upload_data/record_data.dart';
import '../../../../../data/relationship_brand_prodcut_category/brnad_category_repository.dart';
import '../../../../../data/relationship_brand_prodcut_category/product_category_repository.dart';
import '../../../../../data/repositories_authentication/banners/banners_repository.dart';
import '../../../../../data/repositories_authentication/brands/brand_repository.dart';
import '../../../../../data/repositories_authentication/categories/category_repository.dart';
import '../../../../../data/repositories_authentication/product/product_repository.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../model/firebase_model/dummy_data_model.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller1 = MDummyData();
    final controller2 = Get.put(CategoryRepository());
    final controller3 = Get.put(BannerRepository());
    final controller4 = Get.put(ProductRepository());
    final controller5 = Get.put(BrandRepository());
    final controllers6 = Get.put(BrandCategoryRepository());
    final controllers7 = Get.put(ProductCategoryRepository());
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Upload Data"),
        showBackArrow: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Main Record",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controller2.isLoading.value
                    ? const Center(child: SpinkitLoader())
                    : MRecordData(
                        icon: Iconsax.category,
                        text: "Upload Categories",
                        size: MSizes.iconLg,
                        // onTap: () => Get.to(() => Dummmm()),
                        onTap: () =>
                            controller2.uploadDummyData(controller1.categories),
                      ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controller5.isLoading.value
                    ? const Center(child: SpinkitLoader())
                    : MRecordData(
                        icon: Iconsax.shop,
                        text: "Upload Brands",
                        size: MSizes.iconLg,
                        onTap: () =>
                            controller5.uploadDummyData(MDummyData.brands),
                      ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controller4.isLoading.value
                    ? const Center(child: SpinkitLoader())
                    : MRecordData(
                        icon: Iconsax.shopping_cart,
                        text: "Upload Products",
                        size: MSizes.iconLg,
                        onTap: () =>
                            controller4.uploadDummyData(MDummyData.products),
                      ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controller3.isLoading.value
                    ? const Center(
                        child: SpinkitLoader(),
                      )
                    : MRecordData(
                        icon: Iconsax.image,
                        text: "Upload Banners",
                        size: MSizes.iconLg,
                        // onTap: () => Get.to(() => Dummmm()),
                        onTap: () =>
                            controller3.uploadDummyData(MDummyData.banners),
                      ),
                const SizedBox(
                  height: MSizes.spaceBtwSection,
                ),
                Text(
                  "Relationships",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Make sure you have already uploaded all the content above",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controllers6.isLoading.value
                    ? const Center(
                        child: SpinkitLoader(),
                      )
                    : MRecordData(
                        icon: Iconsax.unlimited,
                        text: "Upload Brands & Categories Relation Data",
                        size: MSizes.iconLg,
                        onTap: () => controllers6
                            .uploadDummyData(MDummyData.brandCategory),
                      ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                controllers7.isLoading.value
                    ? const Center(
                        child: SpinkitLoader(),
                      )
                    : MRecordData(
                        icon: Iconsax.unlimited,
                        text: "Upload Products & Categories Relation Data",
                        size: MSizes.iconLg,
                        onTap: () => controllers7
                            .uploadDummyData(MDummyData.productCategory),
                      ),
              ],
            );
          })),
    );
  }
}
