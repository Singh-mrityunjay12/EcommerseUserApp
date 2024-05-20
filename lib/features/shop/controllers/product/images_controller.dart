import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //Variable
  RxString selectedProductImage = ''.obs;

  //Get All the Images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    //Use Set to add unique image only
    Set<String> images = {};

    //Load thumbnail image
    images.add(product.thumbnail);

    //Assign Thumbnail as Selected images
    selectedProductImage.value = product.thumbnail;

    //Get all images from the Product Model if not Null.
    if (product.images != null) {
      images.addAll(product.images!);
    }

    //Get all the Images from Product Variations if not Null.
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }
    return images.toList();
  }

  //Show image Popup
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: MSizes.defaultSpace * 2,
                        horizontal: MSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text("Close")),
                    ),
                  )
                ],
              ),
            ));
  }
}
