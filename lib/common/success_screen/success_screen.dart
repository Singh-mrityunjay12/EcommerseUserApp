import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

import '../../utils/helpers/heleper_functions.dart';
import '../style/spacing_style.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});
  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(
          children: [
            //Images
            // Lottie.asset(image, width: MediaQuery.of(context).size.width * 0.6),
            Image(
              image: AssetImage(image),
              width: MHelperFunction.screenWidth() * 0.6,
            ),
            const SizedBox(
              height: MSizes.spaceBtwSection,
            ),
            //Title & SubTitle
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: MSizes.spaceBtwItems,
            ),

            Text(
              subTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: MSizes.spaceBtwSection,
            ),
            //Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: onPressed, child: const Text(MTexts.tContinue)),
            ),
          ],
        ),
      ),
    );
  }
}
