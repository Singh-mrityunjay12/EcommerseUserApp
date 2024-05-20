import 'package:e_commerce/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../features/authentication/screens/login/login_screen.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';

import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/exception/firebase_auth_exception.dart';
import '../../../utils/local_storage/local_storage.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variable

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final con = Get.put(CartController());

  //Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  //Called from main.dart an app launch
  @override
  void onReady() {
    screenRedirect();
  }

  // @override
  // void onin() {
  //   //Redirect to the appropriate state
  //   // MLocalStorage storage = MLocalStorage.instance();
  //   // Get.put(CartController());
  //   screenRedirect();
  // }

  //Function to Show Relevant Screen
  void screenRedirect() async {
    Future.delayed(const Duration(seconds: 2), () async {
      final user = _auth.currentUser;
      print(
          "/////////////////////////////////////////////////////////////////////////////////ScreenRedirect");
      print(user);
      if (user != null) {
        print("//////////////////////////////RigthMRityu");
        if (user.emailVerified) {
          //Initialize User Specific Storage
          await MLocalStorage.init(user.uid);

          //If the user's email verified then navigate to the main Navigation Menu
          Get.offAll(() => const NavigationMenu());
        } else {
          Get.offAll(() => VerifyEmailScreen(
                email: _auth.currentUser?.email,
              ));
        }
      } else {
        print("//////////////////////////////RigthMRityu12334444554");
        //Local Storage
        if (kDebugMode) {
          print(
              "**********************GET STORAGE Auth Repo************************");
          print(deviceStorage.read("isFirstTime"));
        }
        deviceStorage.writeIfNull("isFirstTime", true);
        //Check if it's the first time launching the app
        print(deviceStorage.read("isFirstTime"));
        //if isFirstTime comes first time then go to OnBoardingScreen() and if isFirstTime come more than one times then go to LoginScreen()
        deviceStorage.read("isFirstTime") != true
            ? Get.offAll(() => const LoginScreen())
            : Get.offAll(() => const OnBoardingScreen());
      }
    });
  }

  /* -----------------------Email & Password Sign-IN---------------- */

  //[EmailAuthentication] -SignIN
  Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw "Something went wrong please try again";
    }
    return userCredential;
  }

  //Re Authentication User
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      //create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      //ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw "Something went wrong please try again";
    }
  }

  //Sign with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the Authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //Create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once Signed In ,return the UserCredential
      return _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong:$e");
      }
      return null;
    }
  }

  //[EmailAuthentication]-Register

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(Get.context!, msg: e.toString());
    }
    return userCredential;
  }

  //Email verification

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw "Something went wrong.Please try again";
    }
  }

  //FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw "Something went wrong.Please try again";
    }
  }

  //LogoutUser Valid for any authentication

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //Delete User Account
  //Remove user Auth and Firebase Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw "Something went wrong please try again";
    }
  }
}
