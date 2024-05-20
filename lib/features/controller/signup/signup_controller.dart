import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../../data/repositories_authentication/user/user_repository.dart';
import '../../authentication/models/user/user_model.dart';
import '../../authentication/screens/signup/verify_email.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Variables

  final hidePassword = true.obs; //Observable for hiding /showing password
  final privacyPolicy = true.obs; //Observable for hiding /showing checkbox
  final email = TextEditingController(); //Controller for email input
  final firstName = TextEditingController(); //Controller for firstName input
  final lastName = TextEditingController(); //Controller for lastName input
  final userName = TextEditingController(); //Controller for username input
  final password = TextEditingController(); //Controller for Password input
  final phoneNumber =
      TextEditingController(); //Controller for phoneNumber input

  GlobalKey<FormState> signKey =
      GlobalKey<FormState>(); //Form key for validation

  //Store device token
  String? device_token;

  void deviceTokenStored(String token) {
    if (token != '') {
      device_token = token;
    }
  }

  //SIGNUP
  Future<void> signUp() async {
    try {
      //Start Loading
      MFullScreenLoader.openLoadingDialog(
          "We are Processing Your Information ", MImage.loadingGif);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        print("/////////////////////////////////////////////////Wrong3");
        return;
      }

      //Form Validation
      if (signKey.currentState!.validate()) {
        print("/////////////////////////////////////////////////Wrong1");

        print("/////////////////////////////////////////////////Wrong2");
      } else {
        return;
      }

      //Privacy Policy check
      if (!privacyPolicy.value) {
        MLoader.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create account you must have to read and accept the Privacy Policy & Term of Use");

        return;
      }

      //Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //Save Authenticate user data in the Firebase Firestore
      // print("/////////////////////////////////////////////////E");
      final newUser = UserModel(
          id: userCredential!.user!.uid,
          token: device_token!,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: "");

      print("///////////////////////////////True1");
      final userRepository = Get.put(UserRepository());
      print("///////////////////////////////True2");
      await userRepository.saveUserRecord(newUser);
      print("///////////////////////////////True3");

      // //Remove Loader
      // MFullScreenLoader.stopLoading();

      // //show success message
      MLoader.successSnackBar(
          title: "Congratulation",
          message: "Your account has been created! Verify email to continue");

      //Move to Verify email screen

      // MFullScreenLoader.stopLoading();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(Get.context!).push(MaterialPageRoute(
            builder: (_) => VerifyEmailScreen(
                  email: email.text.trim(),
                )));
      });
      // Future.delayed(
      //     Duration.zero,
      //     () => Get.to(() => VerifyEmailScreen(
      //           email: email.text.trim(),
      //         )));

      // Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print("/////////////////////////////////////////////////A");

      // MFullScreenLoader.stopLoading();
    } finally {
      //Remove Loader
      MFullScreenLoader.stopLoading();
    }
  }

  Future<void> signUpCall() async {
    await signUp();
  }
}
