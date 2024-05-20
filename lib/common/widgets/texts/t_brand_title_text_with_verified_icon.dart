import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import 't_brand_title_text.dart';

class MBrandTitleWithVerifiedIcon extends StatelessWidget {
  const MBrandTitleWithVerifiedIcon(
      {super.key,
      this.textColor,
      this.maxLines = 1,
      required this.title,
      this.textAlign = TextAlign.center,
      this.brandTextSizes = TextSizes.small,
      this.iconColor = MColors.primary});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSizes: brandTextSizes,
        ),
        const SizedBox(
          width: MSizes.xMin,
        ),
        const Icon(
          Iconsax.verify5,
          color: MColors.primary,
          size: MSizes.iconXs,
        )
      ],
    );
  }
}
