import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../authentication/screens/password_configuration/resset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //Variable
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "Processing your request....", MImage.loadingGif);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Send Email Reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //Remove Loader
      MFullScreenLoader.stopLoading();

      //Show Success Screen
      MLoader.successSnackBar(
          title: 'Email Sent',
          message: "Email Link Sent Reset Your Password".tr);

      //Redirect
      Get.to(() => ResetPasswordScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      //Remove Loader
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "Processing your request....", MImage.loadingGif);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Send Email Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove Loader
      MFullScreenLoader.stopLoading();

      //Show Success Screen
      MLoader.successSnackBar(
          title: 'Email Sent',
          message: "Email Link Sent Reset Your Password".tr);
    } catch (e) {
      //Remove Loader
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
