import 'dart:convert';

import 'package:e_commerce/utils/local_storage/local_storage.dart';

import 'package:get/get.dart';

import '../../../../common/widgets/loadders/loadders.dart';
import '../../../../data/repositories_authentication/product/product_repository.dart';
import '../../models/product_model.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  //Variable
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  //Method to Initialized favorite by reading from storage

  void initFavorites() {
    final json = MLocalStorage.instance().readData('favorites');
    if (json != null) {
      //JsonDecode take a string list or ....then give a object....like that var decoded = json.decode('["foo", { "bar": 499 }]');
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    //If the product present then return true and false the return false
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      MLoader.customToast(message: "Product has been added in the Wishlist.");
    } else {
      MLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh(); //Use this function we got update favorites
      MLoader.customToast(
          message: "Product has been remove from the Wishlist.");
    }
  }

  void saveFavoritesToStorage() {
    //json.encode take a list or... then convert into String Formate.. like that var encoded = json.encode([1, 2, { "a": null }]);
    final encodedFavorites = json.encode(favorites);
    MLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProduct() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
