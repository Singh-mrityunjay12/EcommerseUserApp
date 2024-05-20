import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/errorHandle/error_handle.dart';
import '../../../features/authentication/models/user/user_model.dart';
import '../authentication/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  FirebaseAuth auth1 = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Function to save user data to Firebase

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db
          .collection("Users")
          .doc(auth1.currentUser?.uid)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }

  //CRUD OPERATION  C->CREATE(STORE THE DATA INTO FIREBASE) ,R->READ(FETCH FROM FIREBASE),U->UPDATE(UPDATE DATA INTO FIREBASE),D-> DELETE(REMOVE) (DELETE DATA FROM FIREBASE)
  //Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      //Firebase return DocumentSnapshot into formate of the json like this(DocumentSnapshot<Map<String, dynamic>>)
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }

  //Function to update user data in Firebase

  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }

  //Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }

  //Function to remove user data from firebase
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }

  //Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw FetchDataException("An error occurred : [Status Code : $e]");
    } catch (e) {
      throw "Something went wrong ,Please try again";
    }
  }
}
