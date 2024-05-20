import 'package:e_commerce/features/persionalization/screens/address/address.dart';
import 'package:e_commerce/features/persionalization/screens/settings/widgets/upload_data.dart';
import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/features/shop/screens/order/order.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories_authentication/authentication/authentication_repository.dart';

import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../profile/profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MPrimaryHeaderContainer(
                child: Column(
              children: [
                MAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: MColors.white),
                  ),
                ),

                //user profile card
                MUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: MSizes.spaceBtwSection,
                ),
              ],
            )),
            //Body
            Padding(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                children: [
                  //Account setting
                  const MSectionHeading(
                    title: "Account Settings",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  MSettingMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subTitle: "Set shopping delivery address",
                      onTap: () {
                        Get.to(() => const UserAdressScreen());
                      }),

                  MSettingMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: "My Cart",
                      subTitle: "Add, remove products and move to checkout",
                      onTap: () {
                        Get.to(() => const CartScreen());
                      }),

                  MSettingMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subTitle: "In-progress and Complete Orders",
                      onTap: () {
                        Get.to(() => const OrderScreen());
                      }),
                  MSettingMenuTile(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    onTap: () {},
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    onTap: () {},
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subTitle: "Get any kind of notification message",
                    onTap: () {},
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subTitle: "Manage data usage and connected account",
                    onTap: () {},
                  ),

                  //App setting
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  const MSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subTitle: "Upload Data to your cloud firebase",
                    onTap: () => Get.to(() => const UploadDataScreen()),
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subTitle: "Set recommendation based on location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe mode",
                    subTitle: "Search result is safe for all ages",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  MSettingMenuTile(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subTitle: "Set image quality to be seen",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  //Logout Buttons
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text("Logout")),
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection * 2.5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
