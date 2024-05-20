import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../features/shop/models/brand_category_model.dart';
import '../../utils/exception/firebase_auth_exception.dart';
import '../../utils/exception/formate_exceptions.dart';
import '../../utils/exception/platform_exceptions.dart';

class BrandCategoryRepository extends GetxController {
  static BrandCategoryRepository get instance => Get.find();
  //variable
  final _db = FirebaseFirestore.instance;
  final isLoading = false.obs;

  //BrandCategory relationship data store in FirebaseFirestore
  //Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<BrandCategoryModel> products) async {
    try {
      isLoading.value = true;

      //Loop through each product
      for (var product in products) {
        //Store Product in Firebase
        await _db.collection("BrandCategory").doc().set(product.toJson());
      }
      isLoading.value = false;
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
