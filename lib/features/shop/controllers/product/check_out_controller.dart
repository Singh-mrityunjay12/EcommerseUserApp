import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(image: MImage.paypalPay, name: 'Paypal');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MSectionHeading(
                      title: "Select Payment Method",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: MSizes.spaceBtwSection,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.paypalPay, name: 'PayPal')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.googlePay, name: 'GooglePay')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.paytmPay, name: 'PaytmPay')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.applePay, name: 'ApplePay')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.visaPay, name: 'VisaPay')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.masterCardPay,
                            name: 'MasterCardPay')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.payStackPay, name: 'PaysStack')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    ),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            image: MImage.creditCardPay, name: 'Credit Card')),
                    const SizedBox(
                      height: MSizes.spaceBtwItems / 2,
                    )
                  ],
                ),
              ),
            ));
  }
}
