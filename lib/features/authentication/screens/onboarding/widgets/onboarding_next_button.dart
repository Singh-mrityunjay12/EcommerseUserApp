import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/heleper_functions.dart';
import '../../../controllerOnboarding/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Positioned(
        right: MSizes.defaultSpace,
        bottom: MDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? MColors.primary : Colors.black),
            onPressed: () => OnBoardingController.instance.nextPage(),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
