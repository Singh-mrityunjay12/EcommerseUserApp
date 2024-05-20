import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/persionalization/screens/settings/settings.dart';
import 'features/shop/screens/home/home_screen.dart';
import 'features/shop/screens/store/store.dart';

import 'features/shop/screens/wishlist/wishlist.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/heleper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
                height: 50,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                backgroundColor: dark ? MColors.black : MColors.white,
                indicatorColor: dark
                    ? MColors.white.withOpacity(0.1)
                    : MColors.black.withOpacity(0.1),
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Iconsax.home), label: "Home"),
                  NavigationDestination(
                      icon: Icon(Iconsax.shop), label: "Store"),
                  NavigationDestination(
                      icon: Icon(Iconsax.heart), label: "Wishlist"),
                  NavigationDestination(
                      icon: Icon(Iconsax.user), label: "Profile"),
                ])),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        body: Obx(
          () => controller.screen[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screen = [
    const HomeScreen(),
    const StoreScreen(),
    const FavoriteScreen(),
    const SettingScreen()
  ];
}
