import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../common/success_screen/success_screen.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../utils/constants/image_string.dart';
import '../splash_screen/splash_controller.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  final controller = Get.put(SplashController());

  //Send  Email whenever verify screen  appears & set timer for auto redirect

  @override
  void onInit() {
    // TODO: implement onInit
    sendEmailVerification();
    setTimerAutoRedirect();
    super.onInit();
  }

  //send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MLoader.successSnackBar(
          title: "Email sent",
          message: "Please check your Inbox and verify your email");
    } catch (e) {
      MLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  //Timer to automatically redirect on email verification
  setTimerAutoRedirect() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: MImage.paymentSuccessGif1,
            title: MTexts.yourAccountCreatedTitle,
            subTitle: MTexts.yourAccountCreatedSubTitle,
            onPressed: () => controller.ChangeScreen()));
      }
    });
  }

  //Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: MImage.paymentSuccessGif1,
          title: MTexts.yourAccountCreatedTitle,
          subTitle: MTexts.yourAccountCreatedSubTitle,
          onPressed: () => controller.ChangeScreen()));
    }
  }
}
