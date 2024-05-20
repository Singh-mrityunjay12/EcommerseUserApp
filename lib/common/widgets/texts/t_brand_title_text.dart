import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';

class MBrandTitleText extends StatelessWidget {
  const MBrandTitleText(
      {super.key,
      this.color,
      this.maxLines = 2,
      required this.title,
      this.textAlign = TextAlign.center,
      this.brandTextSizes = TextSizes.small});

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      //Check which brandSize is required and set that style
      style: brandTextSizes == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSizes == TextSizes.medium
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : brandTextSizes == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
