import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/m_launched_images.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/shimmer/horizobtal_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';
import '../product_all/product_all.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.insatance;

    return Scaffold(
      appBar: MAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              const MRoundedImages(
                  width: double.infinity,
                  applyImageRadius: true,
                  imageUrl: MImage.banners2),
              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),

              //sub categories

              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    //Handle Loader ,No Record ,Error message
                    final loader = MHorizontalProductShimmer();
                    final widget = MCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) {
                      return widget;
                    }
                    //Record Found!
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];

                          return FutureBuilder(
                              future: controller.getCategoryProduct(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                //Handle Loader ,No Record ,Error message

                                final widget =
                                    MCloudHelperFunction.checkMultiRecordState(
                                        snapshot: snapshot, loader: loader);
                                if (widget != null) {
                                  return widget;
                                }
                                //Record Found!
                                final products = snapshot.data;
                                return Column(
                                  children: [
                                    //Heading
                                    MSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(() => AllProduct(
                                            title: subCategory.name,
                                            futureMethod:
                                                controller.getCategoryProduct(
                                                    categoryId: subCategory.id,
                                                    limit: -1),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: MSizes.spaceBtwItems / 2,
                                    ),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        itemCount: products!.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: MSizes.spaceBtwItems,
                                        ),
                                        itemBuilder: (context, index) =>
                                            MProductCardHorizontal(
                                          product: products[index],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: MSizes.spaceBtwSection,
                                    ),
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
