import 'package:e_commerce/features/persionalization/screens/profile/widgets/change_name.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/shimmer/loadingIndicator.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/user_controller.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
        appBar: const MAppBar(
          showBackArrow: true,
          title: Text("Profile"),
        ),
        //Body
        body: SingleChildScrollView(
            child: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                //Profile Screen
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : MImage.userLogo1;
                        return controller.imageLoading.value
                            ? const MShimmerEffect(
                                width: 80,
                                height: 80,
                                radius: 80,
                              )
                            //  const CircularProgressIndicator(
                            //     backgroundColor: Colors.blue,
                            //   )
                            : MCircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      }),
                      TextButton(
                          onPressed: () =>
                              controller.uploadUserProfilePicture(),
                          child: const Text("Change Profile Picture"))
                    ],
                  ),
                ),
                //Detail
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                const MSectionHeading(
                  title: "Profile Information",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),

                MProfileMenu(
                    onPressed: () => Get.to(() => const ChangeName()),
                    title: "Name",
                    value: controller.user.value.fullName),

                MProfileMenu(
                    onPressed: () {},
                    title: "Username",
                    value: controller.user.value.username),

                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                //Heading Personal Information
                const MSectionHeading(
                  title: "Personal Information",
                  showActionButton: false,
                ),

                MProfileMenu(
                    onPressed: () {},
                    title: "UserId",
                    icon: Iconsax.copy,
                    value: controller.user.value.id),
                MProfileMenu(
                    onPressed: () {},
                    title: "E-mail",
                    value: controller.user.value.email),
                MProfileMenu(
                    onPressed: () {},
                    title: "Phone Number",
                    value: "+91 ${controller.user.value.phoneNumber}"),
                MProfileMenu(onPressed: () {}, title: "Gender", value: "Male"),
                MProfileMenu(
                    onPressed: () {},
                    title: "Date of Birth",
                    value: "15 Aug 2002"),
                const Divider(),
                const SizedBox(
                  height: MSizes.spaceBtwItems,
                ),
                Center(
                  child: TextButton(
                      onPressed: () => controller.deleteAccountWarningPopup(),
                      child: const Text(
                        "Close Account",
                        style: TextStyle(color: Colors.red),
                      )),
                )
              ],
            ),
          ),
        )));
  }
}
