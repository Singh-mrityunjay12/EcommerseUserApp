import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';
import '../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../data/repositories_authentication/user/user_repository.dart';
import '../../../utils/constants/image_string.dart';
import '../../authentication/models/user/user_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../../controller/signup/signup_controller.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final profileLoading = false.obs;
  final imageLoading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final userRepository = Get.put(UserRepository());
  final controller = SignUpController.instance;
  Rx<UserModel> user = UserModel.empty().obs; //observable user object

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //fetch user record
  Future<void> fetchUserRecord() async {
    try {
      //Before Loading Data
      profileLoading.value = true;

      final user = await userRepository.fetchUserDetails();
      this.user(user);
      //After Loading Data
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //Save User Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      ///First Update Rx User and then check if user data is already stored . if not store new data
      await fetchUserRecord();

      //if no record already stored
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          //Convert the Name to first and last Name
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? "");
          final username = UserModel.generateUserName(
              userCredential.user!.displayName ?? "");

          //Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              token: controller.device_token!,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
              username: username,
              email: userCredential.user!.email ?? "",
              phoneNumber: userCredential.user!.phoneNumber ?? "",
              profilePicture: userCredential.user!.photoURL ?? "");

          //Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      MLoader.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrong while saving your information.You can re-save your data in your Profile ");
    }
  }

  //Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
        confirm: ElevatedButton(
          onPressed: () => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: MSizes.lg),
            child: Text("Delete"),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  //Delete User Account
  void deleteUserAccount() async {
    try {
      MFullScreenLoader.openLoadingDialog('Processing', MImage.loadingGif);
      //First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          MFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          MFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoader.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  //Re Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      MFullScreenLoader.openLoadingDialog("Processing", MImage.loadingGif);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      MFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoader.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  //Upload profile image

  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageLoading.value = true;

        final imageUrl =
            await userRepository.uploadImage("Users/Images/Profile/", image);

        //update user image record
        Map<String, dynamic> json = {"ProfilePicture": imageUrl};
        await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl;

        imageLoading.value = false;

        user.refresh();

        MLoader.successSnackBar(
            title: "Congratulations",
            message: "Your Profile Image has been uploaded");
      }
    } catch (e) {
      print("//////////////////////////////wrong");
      MLoader.errorSnackBar(
          title: "Oh Snap!", message: "Something went wrong:$e");
    } finally {
      print("//////////////////////////////right");
      imageLoading.value = false;
    }
  }
}
