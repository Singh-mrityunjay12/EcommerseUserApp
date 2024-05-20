import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/all_product_controller.dart';

import '../../models/product_model.dart';

class MSortableProducts extends StatelessWidget {
  const MSortableProducts({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            //Sort products based on the selected option
            controller.sortProducts(value!);
          },
          //First Method
          // items: [DropdownMenuItem(child: Text("Name"),

          // )],
          //Second Method
          items: [
            'Name',
            'Higher',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(
          height: MSizes.spaceBtwSection,
        ),
        Obx(() => MGridLayOut(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                MProductCardVertical(product: controller.products[index])))
      ],
    );
  }
}
