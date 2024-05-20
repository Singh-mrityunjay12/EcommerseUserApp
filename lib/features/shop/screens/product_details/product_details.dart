import 'package:e_commerce/features/shop/screens/product_details/widgets/prodcut_meta_data.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_attribute.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

import '../../models/product_model.dart';
import '../product_reviews/product_reviews.dart';
import 'widgets/bottom_add_cart_widget.dart';
import 'widgets/product_details_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product Image Slider
            MProductImageSlider(
              product: product,
            ),
            //Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: MSizes.defaultSpace,
                  left: MSizes.defaultSpace,
                  bottom: MSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Ratting & Share Button
                  const MRatingAndShare(),
                  //Price,Title,Stock & Brand
                  MProductMetaData(
                    product: product,
                  ),
                  //Attribute
                  if (product.productType == ProductType.variable.toString())
                    MProductAttribute(
                      product: product,
                    ),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(
                      height: MSizes.spaceBtwSection,
                    ),

                  //Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Checkout")),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  const MSectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  product.productType == ProductType.single.toString()
                      ? ReadMoreText(
                          //  product.productType==ProductType.single.toString()?
                          product.description ?? '',
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Less',
                          moreStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                          lessStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        )
                      :
                      // Text(
                      //     product.productVariations![2].description ?? '',
                      //   ),
                      ReadMoreText(
                          //  product.productType==ProductType.single.toString()?
                          product.description ?? '',
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Less',
                          colorClickableText: Colors.red,
                          moreStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                          lessStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),

                  //Reviews
                  const Divider(),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MSectionHeading(
                        title: 'Reviews (199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(() => const ProductReviewsScreen());
                        },
                        // Get.to(() =>  ProductReviewsScreen()

                        icon: const Icon(
                          Iconsax.arrow_right_4,
                          size: 18,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
