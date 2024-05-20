import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../common/success_screen/success_screen.dart';
import '../../../../common/widgets/loadders/loadders.dart';
import '../../../../common/widgets/popups/full_screen_loader.dart';
import '../../../../data/orders/order_repository.dart';
import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../persionalization/controller/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'check_out_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //Variable
  final cartController = CartController.instance;
  final addressController = Get.put(AddressController());
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //Fetch user order history
  Future<List<OrderModel>> fetchUsersOrders() async {
    try {
      print('////////////////////////////////////////Q');
      final usersOrders = await orderRepository.fetchUserOrders();
      print('////////////////////////////////////////R');
      return usersOrders;
    } catch (e) {
      MLoader.warningSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  //Add Method for order processing

  void processOrder(double totalAmount) async {
    try {
      //Start loader
      MFullScreenLoader.openLoadingDialog(
          'Processing your order', MImage.pencilGif3);

      //Get user authentication id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        return;
      }

      //Add Details
      final order = OrderModel(
          //Generate a unique id for the order
          id: UniqueKey().toString(),
          uuid: orderRepository.uuid,
          userId: userId,
          status: OrderStatus.processing,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          //Set Date as needed
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList());

      //Save the order in Firebase
      await orderRepository.saveOrder(order, userId);
      await orderRepository.saveOrder1(order);
      //Update the cart status
      cartController.clearCart();

      //Show success screen
      Get.offAll(() => SuccessScreen(
            image: MImage.paymentSuccessGif1,
            title: "Payment Success!",
            subTitle: "Your Item will be shipped soon!",
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
