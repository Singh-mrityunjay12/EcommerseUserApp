import 'package:e_commerce/features/shop/controllers/product/variation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/chioce_chip.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../models/product_model.dart';

class MProductAttribute extends StatelessWidget {
  const MProductAttribute({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(() => Column(
          children: [
            //Selecting Attribute Pricing & Description
            //Display variations price and stock when some variation is selected
            if (controller.selectedVariation.value.id.isNotEmpty)
              MRoundedContainer(
                padding: const EdgeInsets.all(MSizes.md),
                backgroundColor: dark ? MColors.darkerGrey : MColors.grey,
                child: Column(
                  children: [
                    //Title ,Price, and Stock Status
                    Row(
                      children: [
                        const MSectionHeading(
                          title: "Variation",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          width: MSizes.spaceBtwItems,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const MProductTitleText(
                                  title: "Price",
                                  smallSize: true,
                                ),
                                const SizedBox(
                                  width: MSizes.spaceBtwItems,
                                ),
                                //Actual price
                                if (controller
                                        .selectedVariation.value.salePrice >
                                    0)
                                  Text(
                                    "\$${controller.selectedVariation.value.price}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                const SizedBox(
                                  width: MSizes.spaceBtwItems,
                                ),
                                //Sale Price
                                MProductPriceText(
                                    price: controller.getVariationPrice())
                              ],
                            ),
                            //Stock
                            Row(
                              children: [
                                const MProductTitleText(
                                  title: "Stock ",
                                  smallSize: true,
                                ),
                                Text(
                                  controller.variationStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    //Variation Description
                    MProductTitleText(
                      title:
                          controller.selectedVariation.value.description ?? '',
                      smallSize: true,
                      maxLines: 4,
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: MSizes.spaceBtwItems,
            ),
            //Attributes
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: product.productAttributes!
                    .map(
                      (attribute) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MSectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: MSizes.spaceBtwItems / 2,
                          ),
                          Obx(() => Wrap(
                              spacing: 8,
                              children: attribute.values!.map(
                                (attributeValue) {
                                  final isSelected = controller
                                          .selectedAttributes[attribute.name] ==
                                      attributeValue;

                                  final available = controller
                                      .getAttributeAvailabilityInVariation(
                                          product.productVariations!,
                                          attribute.name!)
                                      .contains(attributeValue);
                                  return MChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onSelected: available
                                          ? (selected) {
                                              if (selected && available) {
                                                controller.onAttributeSelected(
                                                    product,
                                                    attribute.name ?? '',
                                                    attributeValue);
                                              }
                                            }
                                          : null);
                                },
                              ).toList()))
                        ],
                      ),
                    )
                    .toList()),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const MSectionHeading(title: "Size"),
            //     const SizedBox(
            //       height: MSizes.spaceBtwItems / 2,
            //     ),
            //     Wrap(
            //       spacing: 8,
            //       children: [
            //         MChoiceChip(
            //           text: "EU 34",
            //           selected: true,
            //           onSelected: (value) {},
            //         ),
            //         MChoiceChip(
            //           text: "EU 41",
            //           selected: false,
            //           onSelected: (value) {},
            //         ),
            //         MChoiceChip(
            //           text: "EU 36",
            //           selected: false,
            //           onSelected: (value) {},
            //         ),
            //       ],
            //     )
            //   ],
            // )
          ],
        ));
  }
}
