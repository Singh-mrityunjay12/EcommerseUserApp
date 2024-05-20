import 'package:e_commerce/features/shop/controllers/product/images_controller.dart';

import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';
import 'cart_controller.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variables

  RxMap selectedAttributes = {}.obs;

  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  //Select Attribute, and variations
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValues) {
    getProductVariationStockStatus();
    //When attribute is selected we will first add that attribute to the selectedAttribute
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValues;
    this.selectedAttributes[attributeName] = attributeValues;

    final selectedVariations = product.productVariations!.firstWhere(
        (variation) => _isSameAttributeValues(
            variation.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());

    //Show the selected Variation image as a Main Variation
    if (selectedVariations.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariations.image;
    }

    //Show selected variation quantity already in the cart
    if (selectedVariations.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariations.id);
    }

    //Assign Selected Variation
    selectedVariation.value = selectedVariations;
  }
  //Check If Selected attribute matches any variation attributes

  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    //If SelectedAttributes contains 3 attribute and  current  variation contain 2 then return .
    if (variationAttributes.length != selectedAttributes.length) return false;

    //If any of attribute is different then return. e.g. [Green,Large]*[Green,Small]

    for (final key in variationAttributes.keys) {
      //Attribute[Key]=Values which could be [Green,Small,Cotton] ets.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  //Check Attribute  availability /Stock in Variation
  Set<String?> getAttributeAvailabilityInVariation(
      List<ProductVariationModel> variation, String attributeName) {
    //Pass the variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues = variation
        .where((variation) =>
            //Check Empty /Out of Stock Attributes

            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        //Fetch all non-empty attribute of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  //Sale Price
  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  //Check Product variation Stock Status

  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  //Reset Selected Attribute when Switching products

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
