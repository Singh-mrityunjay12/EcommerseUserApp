import 'package:e_commerce/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce/utils/constants/enums.dart';

import 'package:get/get.dart';

import '../../../../common/widgets/loadders/loadders.dart';

import '../../../../utils/local_storage/local_storage.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //Variable
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

//Constructor
  CartController() {
    loadCartItems();
  }

  //Add item in the
  void addToCart(ProductModel product) {
    //Quantity Check
    if (productQuantityInCart.value < 1) {
      MLoader.customToast(message: "Select Quantity");
      return;
    }

    //Variations Selected
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      MLoader.customToast(message: "Select Variation");
      return;
    }

    //Out of Stock Status
    if (product.productType == ProductType1.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        MLoader.warningSnackBar(
            title: "Selected Variations is out of stock", message: 'Oh Snap!');
        return;
      }
    } else {
      if (product.stock < 1) {
        MLoader.warningSnackBar(
            title: "Selected Product is out of stock", message: 'Oh Snap!');
        return;
      }
    }

    //Convert the ProductModel to a CartItemModel with the given quantity

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    //Check if already added in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);
    if (index >= 0) {
      //This quantity already added or Updated/Removed from the design(Cart)(-)
      cartItems[index].quantity == selectedCartItem.quantity;
    } else {
      //here add this quantity if it is not available in cartItems
      cartItems.add(selectedCartItem);
    }

    updateCart();
    MLoader.customToast(message: 'Your product has been added to the cart');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        //show the dialog before completely removing
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Product",
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        //Remove item from the cart
        cartItems.removeAt(index);
        updateCart();
        MLoader.customToast(message: 'Product removed from the cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  //Initialize already added item's Count in the cart
  void updateAlreadyAddedProductCount(ProductModel product) {
    //if product has no variations then calculate cartEntries and display total number
    //Else make default entries to 0 and show cartEntries when variations is selected

    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      //Get selected variations if any
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  //This function convert a ProductModel to a CartItemModel

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      //Reset variations in case of single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
        productId: product.id,
        title: product.title,
        price: price,
        quantity: quantity,
        variationId: variation.id,
        image: isVariation ? variation.image : product.thumbnail,
        brandName: product.brand != null ? product.brand!.name : '',
        selectedVariations: isVariation ? variation.attributeValues : null);
  }

  //Update cart value

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    MLocalStorage.instance().saveData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final cartItemsStrings =
        MLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemsStrings != null) {
      cartItems.assignAll(cartItemsStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
