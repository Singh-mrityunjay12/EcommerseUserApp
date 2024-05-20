import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/loadders/animation_loadder.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllers/product/order_controller.dart';

class MOrderListItems extends StatelessWidget {
  const MOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final dark = MHelperFunction.isDarkMode(context);

    return FutureBuilder(
        future: orderController.fetchUsersOrders(),
        builder: (context, snapshot) {
          //Nothing found widget
          final emptyWidget = MAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet',
            animation: MImage.successfullyRegisterAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          //Handle Loader or No Record or error message
          final result = MCloudHelperFunction.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (result != null) return result;

          //Record Found!

          final orders = snapshot.data!;

          return ListView.separated(
            itemCount: orders.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) =>
                const SizedBox(height: MSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final order = orders[index];
              return MRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? MColors.dark : MColors.light,
                padding: const EdgeInsets.all(MSizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  //Order
                  //Row 1
                  children: [
                    Row(
                      children: [
                        //Icon
                        const Icon(Iconsax.ship),
                        const SizedBox(
                          height: MSizes.spaceBtwItems / 2,
                        ),
                        //Status & Date
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderStatusText,
                                // "fggghhh",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: MColors.primary,
                                        fontWeightDelta: 1),
                              ),
                              Text(
                                order.formattedOrderDate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        //Icon
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Iconsax.arrow_right_34,
                              size: MSizes.iconSm,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: MSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        //Row 2
                        Flexible(
                          child: Row(
                            children: [
                              //Icon
                              const Icon(Iconsax.tag),
                              const SizedBox(
                                height: MSizes.spaceBtwItems / 2,
                              ),
                              //Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.id,
                                      // "id",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                              //Icon
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Iconsax.arrow_right_34,
                                    size: MSizes.iconSm,
                                  ))
                            ],
                          ),
                        ),
                        //Row 3
                        //Delivery  Date
                        Flexible(
                          child: Row(
                            children: [
                              //Icon
                              const Icon(Iconsax.calendar),
                              const SizedBox(
                                height: MSizes.spaceBtwItems / 2,
                              ),
                              //Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Shipping Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.formattedDeliveryDate != ''
                                          ? order.formattedDeliveryDate
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                              //Icon
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Iconsax.arrow_right_34,
                                    size: MSizes.iconSm,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
