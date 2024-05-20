import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/carts/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmer/loadingIndicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../persionalization/controller/user_controller.dart';
import '../../cart/cart.dart';

class MHomeAppBar extends StatelessWidget {
  const MHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return MAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: MColors.grey),
          ),
          Obx(
            () {
              if (controller.profileLoading.value) {
                //Display a shimmer loader while user profile is being loaded
                return const MShimmerEffect(width: 80, height: 15);
              } else {
                return Text(
                  controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: MColors.white),
                );
              }
            },
          ),
        ],
      ),
      actions: [
        // Icon(Icons.add)
        MCartCounterIcon(
          onPressed: () => Get.to(() => const CartScreen()),
          iconColor: MColors.white,
        )
      ],
    );
  }
}
