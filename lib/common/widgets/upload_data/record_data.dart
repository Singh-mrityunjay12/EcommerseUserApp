import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';

class MRecordData extends StatelessWidget {
  const MRecordData(
      {super.key,
      required this.icon,
      required this.text,
      this.size,
      this.onTap});

  final IconData icon;
  final String text;
  final double? size;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(MSizes.md),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: MColors.primary,
                    size: size,
                  ),
                  const SizedBox(
                    width: MSizes.md,
                  ),
                  Text(
                    text,
                    // maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: dark ? MColors.light : MColors.dark,
                        ),
                  ).expand()
                ],
              ),
            ),
            Icon(
              Icons.arrow_circle_up,
              color: MColors.primary,
              size: size,
            )
          ],
        ),
      ),
    );
  }
}
