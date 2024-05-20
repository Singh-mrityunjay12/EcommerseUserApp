import 'package:e_commerce/features/shop/controllers/product/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/loadders/loadders.dart';
import '../../../../common/widgets/products/carts/coupon_widget.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_item1.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';
import 'widgets/billing_payment_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orederController = Get.put(OrderController());
    final totalAmount =
        MPricingCalculator.calculateTotalPrice(subTotal, 'India');
    final dark = MHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: MAppBar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //Item in Cart
              const MCartItem1(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),

              //Coupon TextField
              const MCouponCode(),

              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),

              //Billing Section
              MRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? MColors.black : MColors.white,
                padding: const EdgeInsets.all(MSizes.md),
                child: const Column(
                  children: [
                    //Pricing
                    MBillingAmountSection(),
                    SizedBox(
                      height: MSizes.spaceBtwItems,
                    ),
                    //Divider
                    Divider(),
                    SizedBox(
                      height: MSizes.spaceBtwItems,
                    ),
                    //Payment method
                    MBillingPaymentSection(),
                    SizedBox(
                      height: MSizes.spaceBtwItems,
                    ),
                    MBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orederController.processOrder(totalAmount)
                : () => MLoader.warningSnackBar(
                    title: "Empty Cart",
                    message: 'Add items in the cart in order to proceed'),
            child: Text("Checkout \$${totalAmount}")),
      ),
    );
  }
}
