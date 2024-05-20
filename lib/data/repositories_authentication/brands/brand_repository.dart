import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exception/firebase_auth_exception.dart';
import '../../../utils/exception/formate_exceptions.dart';
import '../../../utils/exception/platform_exceptions.dart';
import '../../services/firebase_storage_service/firebase_storage_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;
  final isLoading = false.obs;

  //Get all Categories

  Future<List<BrandModel>> getAllBrands() async {
    try {
      //Query of cloud FirebaseFirestore
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .while fetching Brands';
    }
  }

  //Upload brands to the cloud firebase

  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      isLoading.value = true;
      //Upload all the Categories along with their Images
      final storage = Get.put(MFirebaseStorageService());
      print(
          "//////////////////////////////////////////////////////////////////////Right");

      //loop for each category
      for (var brand in brands) {
        print(
            "//////////////////////////////////////////////////////////////////////Wrong");
        print(brand);
        print("Ans");
        print(brand.image.toString());
        final mri = brand.image;
        //Get ImageData link from the local assets
        Uint8List file = await storage.getImageDataFromAssets(mri);
        // print(file);

        print(
            "//////////////////////////////////////////////////////////////////////AAAAAAAAAAAAa");
        // //Upload Image and Get's its Url
        final url = await storage.uploadImageData("Brands", file, brand.name);
        print(
            "//////////////////////////////////////////////////////////////////////BBBBB");
        // //Assign URL to category.image attribute
        brand.image = url;

        print(
            "//////////////////////////////////////////////////////////////////////CCCCCC");
        //Store Category in Firebase
        await _db.collection("Brands").doc(brand.id).set(brand.toJson());
      }

      isLoading.value = false;
      Get.offAll(const NavigationMenu());
      // return file!;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
  //Get Brands for Category

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      //Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db
          .collection("BrandCategory")
          .where('CategoryId', isEqualTo: categoryId)
          .get();

      //Extract brandIds from the document
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['BrandId'] as String)
          .toList();

      //Query to get all documents where the brandId is in the list of brandIds , FieldPath.documentId to query document collection
      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      //Extract brand names or other relevant data from the documents
      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .while fetching Brands';
    }
  }

  //Get Brand Specific Products from your data source
}
