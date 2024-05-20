import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../navigation_menu.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../../authentication/screens/onboarding/onboarding.dart';
import '../../authentication/screens/signup/verify_email.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  //created a method to change the screen
  ChangeScreen() async {
    _auth.authStateChanges().listen((User? user) {
      print(
          "///////////////////////////////////////////////////////////////////////////////////SplashController");
      print(user);

      if (user != null) {
        if (user.emailVerified) {
          Get.offAll(() => const NavigationMenu());
        } else {
          Get.offAll(() => VerifyEmailScreen(
                email: _auth.currentUser?.email,
              ));
        }
      } else {
        //yadi user nahi login hoga tab ham log login page per jayege

        final deviceStorage = GetStorage();

        deviceStorage.read("isFirstTime") != true
            ? Get.offAll(() => const LoginScreen())
            : Get.offAll(() => const OnBoardingScreen());
      }

      // if (user == null && mounted) {
      //   //yadi user nahi login hoga tab ham log login page per jayege
      //   Get.to(() => LoginScreen());
      // } else {
      //   Get.to(() =>
      //       NavigationMenu()); //yadi user login hoga tab hamlog homePage per chale jayenge
      // }
    });
    // final deviceStorage = GetStorage();

    // deviceStorage.read("isFirstTime") != true
    //     ? Get.offAll(() => const LoginScreen())
    //     : Get.offAll(() => const OnBoardingScreen());
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
  }
}
