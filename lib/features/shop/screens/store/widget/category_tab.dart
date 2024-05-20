import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import '../../product_all/product_all.dart';
import 'category_brands.dart';

class MCategoryTab extends StatelessWidget {
  const MCategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.insatance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(MSizes.spaceBtwProduct),
            child: Column(
              children: [
                //Brands
                CategoryBrands(category: category),

                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                //Product

                FutureBuilder(
                    future:
                        controller.getCategoryProduct(categoryId: category.id),
                    builder: (context, snapshot) {
                      //Helper function:Handle Loader,No Record ,Or Error Message
                      final responce =
                          MCloudHelperFunction.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const MVerticalProductShimmer());

                      if (responce != null) return responce;

                      //Record Found!
                      final products = snapshot.data!;
                      return Column(
                        children: [
                          MSectionHeading(
                            title: "You might like",
                            onPressed: () => Get.to(AllProduct(
                              title: category.name,
                              futureMethod: controller.getCategoryProduct(
                                  categoryId: category.id, limit: -1),
                            )),
                          ),
                          const SizedBox(
                            height: MSizes.spaceBtwItems,
                          ),
                          MGridLayOut(
                              itemCount: products.length,
                              itemBuilder: (_, index) => MProductCardVertical(
                                    product: products[index],
                                  ))
                        ],
                      );
                    })
              ],
            ),
          ),
        ]);
  }
}
