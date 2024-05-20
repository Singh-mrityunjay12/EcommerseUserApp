import 'package:e_commerce/features/controller/signup/signup_controller.dart';
import 'package:e_commerce/features/persionalization/model/firebase_notifications/firebase_notifications.dart';
import 'package:e_commerce/features/shop/controllers/product/check_out_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';

import '../common/widgets/Network/network_manager.dart';
import '../features/shop/controllers/product/variation_controller.dart';

class GeneralBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(SignUpController());
    Get.put(CheckoutController());

    Get.put(FirebaseNotificationController());
  }
}
