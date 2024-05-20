import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllerOnboarding/onboarding_controller.dart';
import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Onboarding"),
      //   elevation: 0,
      //   // backgroundColor: Colors.teal,
      // ),
      body: Stack(
        children: [
          //Horizontal Scroll page

          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: MImage.gifAppLogo1,
                  title: MTexts.onBoardingTitle1,
                  subTitle: MTexts.onBoardingSubTitle1),
              OnBoardingPage(
                  image: MImage.gifAppLogo2,
                  title: MTexts.onBoardingTitle2,
                  subTitle: MTexts.onBoardingSubTitle2),
              OnBoardingPage(
                  image: MImage.gifAppLogo3,
                  title: MTexts.onBoardingTitle3,
                  subTitle: MTexts.onBoardingSubTitle3)
            ],
          ),

          //Skip button
          const OnBoardingSkip(),

          //Dot Navigation SmoothPageIndicator
          const OnBoardDotNavigation(),

          //Circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
