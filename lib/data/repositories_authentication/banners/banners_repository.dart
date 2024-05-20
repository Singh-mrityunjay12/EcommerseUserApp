import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banners_model.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exception/firebase_auth_exception.dart';
import '../../../utils/exception/formate_exceptions.dart';
import '../../../utils/exception/platform_exceptions.dart';
import '../../services/firebase_storage_service/firebase_storage_service.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;
  final isLoading = false.obs;
  Uint8List? file;

  //Get all order related to current User

  Future<List<BannersModel>> fetchBanners1() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      final list = result.docs
          .map((document) => BannersModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //upload categories to the cloud firebase

  Future<void> uploadDummyData(List<BannersModel> banners) async {
    try {
      isLoading.value = true;
      //Upload all the Categories along with their Images
      final storage = Get.put(MFirebaseStorageService());
      print(
          "//////////////////////////////////////////////////////////////////////Right");

      //loop for each category
      for (var banner in banners) {
        print(
            "//////////////////////////////////////////////////////////////////////Wrong");

        final mri = banner.imageUrl;
        //Get ImageData link from the local assets
        file = await storage.getImageDataFromAssets(mri);
        // print(file);

        print(
            "//////////////////////////////////////////////////////////////////////AAAAAAAAAAAAa");
        // //Upload Image and Get's its Url
        final url =
            await storage.uploadImageData("Banners", file!, banner.name);
        print(
            "//////////////////////////////////////////////////////////////////////BBBBB");
        // //Assign URL to category.image attribute
        banner.imageUrl = url;

        print(
            "//////////////////////////////////////////////////////////////////////CCCCCC");
        //Store Category in Firebase
        await _db.collection("Banners").doc().set(banner.toJson());

        print(
            "/////////////////////////////////////////////////////////Right1233456788");
      }

      isLoading.value = false;
      Get.offAll(() => const NavigationMenu());

      // return file!;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
