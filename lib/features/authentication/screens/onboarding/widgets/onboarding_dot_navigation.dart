import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

import '../../../controllerOnboarding/onboarding_controller.dart';

class OnBoardDotNavigation extends StatelessWidget {
  const OnBoardDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    // final dark1 = MHelperFunction.isDarkMode(context);

    return Positioned(
        bottom: MDeviceUtils.getBottomNavigationBarHeight(),
        left: MSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 3,
          onDotClicked: controller.dotNavigationClick,
          effect: const ExpandingDotsEffect(
              activeDotColor: MColors.dark, dotHeight: 6),
        ));
  }
}
