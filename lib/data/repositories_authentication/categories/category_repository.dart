import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exception/firebase_auth_exception.dart';
import '../../services/firebase_storage_service/firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;
  final isLoading = false.obs;
  Uint8List? file;

  //Get all categories
  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final snapshot = await _db.collection("Categories").get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //Get sub categories

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //upload categories to the cloud firebase

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      isLoading.value = true;
      //Upload all the Categories along with their Images
      final storage = Get.put(MFirebaseStorageService());
      print(
          "//////////////////////////////////////////////////////////////////////Right");

      //loop for each category
      for (var category in categories) {
        print(
            "//////////////////////////////////////////////////////////////////////Wrong");
        print(category);
        print("Ans");
        print(category.image.toString());
        final mri = category.image;
        //Get ImageData link from the local assets
        file = await storage.getImageDataFromAssets(mri);
        // print(file);

        print(
            "//////////////////////////////////////////////////////////////////////AAAAAAAAAAAAa");
        // //Upload Image and Get's its Url
        final url =
            await storage.uploadImageData("Categories", file!, category.name);
        print(
            "//////////////////////////////////////////////////////////////////////BBBBB");
        // //Assign URL to category.image attribute
        category.image = url;

        print(
            "//////////////////////////////////////////////////////////////////////CCCCCC");
        //Store Category in Firebase
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }

      isLoading.value = false;
      Get.offAll(() => const NavigationMenu());
      // return file!;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
