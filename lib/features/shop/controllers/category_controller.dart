import 'package:get/get.dart';

import '../../../common/widgets/loadders/loadders.dart';
import '../../../data/repositories_authentication/categories/category_repository.dart';
import '../../../data/repositories_authentication/product/product_repository.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get insatance => Get.find();

  final loading = false.obs;

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
//Load Category data

  Future<void> fetchCategories() async {
    try {
      //Show loader while loading categories
      loading.value = true;

      //Fetch categories from data source (Firestore ,Api etc.)
      final categories = await _categoryRepository.getAllCategory();

      //Update the categories list
      allCategories.assignAll(categories);
      //Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove Loader
      loading.value = false;
    }
  }

  //Load selected category data

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      MLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  //Get Category or Sub-Category Products

  Future<List<ProductModel>> getCategoryProduct(
      {required String categoryId, int limit = 4}) async {
    //Fetch limited (4) products against each subCategory
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
