//controller to manage user related functionality
import 'package:e_commerce/features/persionalization/controller/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../../data/repositories_authentication/user/user_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../screens/profile/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //init user data when home screen appear

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "we are updating your information.....", MImage.loadingGif);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }
      //  Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Update user's first and last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);
      //
      //Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //Remove Loader
      MFullScreenLoader.stopLoading();

      //Show Success Message
      MLoader.successSnackBar(
          title: "Congratulation", message: "Your Name has been updated");
      //Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
