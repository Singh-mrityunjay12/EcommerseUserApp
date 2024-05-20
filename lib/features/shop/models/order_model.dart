import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../../persionalization/model/adress/adress_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String uuid;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel(
      {required this.id,
      required this.uuid,
      this.userId = '',
      required this.status,
      required this.items,
      required this.totalAmount,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.address,
      this.deliveryDate});

  String get formattedOrderDate => MHelperFunction.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? MHelperFunction.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : status == OrderStatus.pending
              ? 'Pending'
              : status == OrderStatus.cancelled
                  ? 'Cancelled'
                  : 'Processing';

//Store the data in firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'userId': userId,
      'status': status.toString(), //Enum to string
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address!.toJson(), //Convert AddressModel to map
      'deliveryDate': deliveryDate,
      'items': items
          .map((item) => item.toJson())
          .toList() //Convert CartItemModel to map
    };
  }

  //Receive the data from firestore or api
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      uuid: data['uuid'] as String,
      userId: data['userId'] as String,
      status:
          OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] ?? '',
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
