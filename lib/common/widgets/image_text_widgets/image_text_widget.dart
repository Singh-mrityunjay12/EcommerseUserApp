import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../images/t_circular_image.dart';

class MVerticalImageText extends StatelessWidget {
  const MVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MColors.white,
    this.isNetworkImage = true,
    this.backGroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backGroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: MSizes.spaceBtwItems),
        child: Column(
          children: [
            //Circular icon
            MCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: MSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backGroundColor,
              overLayColor: dark ? MColors.light : MColors.dark,
            ),
            // Container(
            //   width: 58,
            //   height: 58,
            //   padding: const EdgeInsets.all(MSizes.sm),
            //   decoration: BoxDecoration(
            //     color:
            //         backGroundColor ?? (dark ? MColors.black : MColors.white),
            //     borderRadius: BorderRadius.circular(100),
            //   ),
            //   child: Center(
            //     child: Image(
            //       image: AssetImage(image),
            //       fit: BoxFit.cover,
            //       // color: dark ? MColors.light : MColors.accent,
            //     ),
            //   ),
            // ),

            //Text
            const SizedBox(
              height: MSizes.spaceBtwItems / 1.8,
            ),
            Expanded(
              child: SizedBox(
                width: 39,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
