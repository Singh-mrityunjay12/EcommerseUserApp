import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/persionalization/controller/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../images/t_circular_image.dart';
import '../shimmer/loadingIndicator.dart';

class MUserProfileTile extends StatelessWidget {
  const MUserProfileTile({
    this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : MImage.userLogo1;
        return controller.imageLoading.value
            ? const MShimmerEffect(
                width: 80,
                height: 80,
                radius: 80,
              )
            // const CircularProgressIndicator(
            //     backgroundColor: Colors.blue,
            //   )
            : MCircularImage(
                image: image,
                width: 56,
                height: 100,
                isNetworkImage: networkImage.isNotEmpty,
              );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: MColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: MColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: MColors.white,
          )),
    );
  }
}
