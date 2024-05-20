import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/login/login_screen.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  ///variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update Current Index  when page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
  //Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    // pageController.jumpToPage(index);
    //OR
    pageController.jumpTo(index);
  }

  //Update Current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      //Storage:Get Storage
      final storage = GetStorage();
      if (kDebugMode) {
        print("**********************GET STORAGE Next Button");
        print(storage.read("isFirstTime"));
      }
      storage.write("isFirstTime",
          false); //after this operation false add in isFirstTime key

      if (kDebugMode) {
        print("**********************GET STORAGE Next Button");
        print(storage.read(
            "isFirstTime")); //after this operation save the value of isFirstTime in any variable
      }
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //Update Current index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
