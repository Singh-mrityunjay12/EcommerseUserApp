import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../persionalization/controller/user_controller.dart';

class LoginController extends GetxController {
  //Variables
  final userController = Get.put(UserController());
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage =
      GetStorage(); //this is similar to shared preference it  uses to store the data login email and password of data
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    email.text == "" ? "" : email.text = localStorage.read("REMEMBER_ME_EMAIL");
    password.text == ""
        ? ""
        : password.text = localStorage.read("REMEMBER_ME_PASSWORD");
    super.onInit();
  }

  //Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "Logging you.... ", MImage.loadingGif);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //isConnected is false means no Internet then stop the loading
        MFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!loginFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //Save the Data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write(
            "REMEMBER_ME_EMAIL",
            email.text
                .trim()); //write function work as json formate means kay and value formate
        //here REMEMBER_ME_EMAIL work as key and email.text.trim() is value and write function uses to store the data and read function uses to
        //read or check the data that what is value store in key
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      //Login user using Email and Password Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Stop(Remove) Loader

      // MFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  //Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "Logging you in.... ", MImage.loadingGif);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //isConnected is false means no Internet then stop the loading
        MFullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
      //Save User Record
      await userController.saveUserRecord(userCredentials);
      //Remove Loader
      // MFullScreenLoader.stopLoading();
      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
