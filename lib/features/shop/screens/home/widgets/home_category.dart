import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/image_text_widgets/image_text_widget.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../controllers/category_controller.dart';
import '../../sub_categories/sub_categories.dart';

class MHomeCategories extends StatelessWidget {
  const MHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.loading.value) return const MCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
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
      return SizedBox(
        height: 125,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            itemBuilder: (context, index) {
              final category = categoryController.featuredCategories[index];
              return MVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () =>
                    Get.to(() => SubCategoriesScreen(category: category)),
              );
            }),
      );
    });
  }
}
