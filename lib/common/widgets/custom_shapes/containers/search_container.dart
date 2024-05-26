import 'package:e_commerce/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/heleper_functions.dart';

class MSearchContainer extends StatelessWidget {
  const MSearchContainer(
      {super.key,
      required this.text,
      this.icon,
      this.showBackground = true,
      this.showBorder = true,
      this.padding = const EdgeInsets.symmetric(
          horizontal: MSizes.spaceBtwProduct, vertical: 7)});

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final dark = MHelperFunction.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        width: MDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: MSizes.sMin),
        decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? MColors.dark
                    : MColors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(MSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: MColors.grey) : null),
        child: TextFormField(
          controller: controller.searchText,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              suffixIcon: const Icon(Icons.search).onTap(() {
                if (controller.searchText.text.trim().isNotEmptyAndNotNull) {
                  Get.to(() => SearchScreen(
                        title: controller.searchText.text.trim(),
                      ));
                  // controller.searchText.clear();
                }
              }),
              filled: true,
              fillColor: MColors.white,
              hintText: 'SearchAnything',
              hintStyle: const TextStyle(color: MColors.grey)),
        ),
      ),
    );
  }
}
