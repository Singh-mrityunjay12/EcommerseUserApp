import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../features/shop/models/order_model.dart';
import '../repositories_authentication/authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  //Variable
  final _db = FirebaseFirestore.instance;
  String uuid = Uuid().v4();

  // String get v1 => uuid.v1();

  //Get all order related to current user

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }
      print('////////////////////////////////////////H');
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      print('////////////////////////////////////////T');
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went to wrong while fetching Order Information. Try again letter';
    }
  }

  //Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .doc(uuid)
          .set(order.toJson());
    } catch (e) {
      throw 'Something went to wrong while saving Order Information. Try again letter';
    }
  }

  //Store new user order

  Future<void> saveOrder1(OrderModel order) async {
    try {
      await _db.collection('Orders').doc(uuid).set(order.toJson());
    } catch (e) {
      throw 'Something went to wrong while saving Order Information. Try again letter';
    }
  }
}
