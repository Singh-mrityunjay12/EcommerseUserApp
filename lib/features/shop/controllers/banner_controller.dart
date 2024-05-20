import 'package:get/get.dart';

import '../../../common/widgets/loadders/loadders.dart';
import '../../../data/repositories_authentication/banners/banners_repository.dart';
import '../models/banners_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  //variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;

  final RxList<BannersModel> banners = <BannersModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  //Update Page Navigational Dots
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  //Fetch Banners

  Future<void> fetchBanners() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      //Fetch Banners
      final bannersRepo = Get.put(BannerRepository());
      final banners = await bannersRepo.fetchBanners1();

      //Assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }
}
