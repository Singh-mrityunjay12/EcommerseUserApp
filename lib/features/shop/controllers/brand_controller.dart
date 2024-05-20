import 'package:get/get.dart';

import '../../../common/widgets/loadders/loadders.dart';

import '../../../data/repositories_authentication/brands/brand_repository.dart';
import '../../../data/repositories_authentication/product/product_repository.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = false.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  //Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      //Show Loader while loading Brand
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      featureBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Stop Loader
      isLoading.value = false;
    }
  }

  //Get Brands For Category
  Future<List<BrandModel>> getBrandsCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
