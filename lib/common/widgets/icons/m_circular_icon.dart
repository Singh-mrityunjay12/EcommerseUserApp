import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';

class MCircularIcon extends StatelessWidget {
  const MCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = MSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor != null
              ? backgroundColor!
              : MHelperFunction.isDarkMode(context)
                  ? MColors.black.withOpacity(0.9)
                  : MColors.white.withOpacity(0.9)),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
