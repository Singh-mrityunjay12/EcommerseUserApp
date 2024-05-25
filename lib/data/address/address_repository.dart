import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../features/persionalization/model/adress/adress_model.dart';

import '../repositories_authentication/authentication/authentication_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchNewUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      print('///////////////////////////////ANS1');

      if (userId.isEmpty)
        throw 'Unable to find user information .Try again in few minutes.';
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      print('///////////////////////////////ANS2');
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while featching Address Information . Try again later';
    }
  }

  //Clear the 'selected' field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again letter';
    }
  }

  //Store new user order

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again letter';
    }
  }

  Future<void> addEditAddress(AddressModel address, String docId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(docId)
          .update(address.toJson());
      update();
      // return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again letter';
    }
  }
}
