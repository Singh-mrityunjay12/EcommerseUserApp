import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../icons/m_circular_icon.dart';

class MProductQualityWithAddRemoveButton extends StatelessWidget {
  const MProductQualityWithAddRemoveButton({
    required this.quantity,
    this.add,
    this.remove,
    super.key,
  });

  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Add Remove Buttons
        MCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: MSizes.md,
          color: MHelperFunction.isDarkMode(context)
              ? MColors.white
              : MColors.black,
          backgroundColor: MHelperFunction.isDarkMode(context)
              ? MColors.darkerGrey
              : MColors.light,
          onPressed: remove,
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),

        MCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: MSizes.md,
          color: MColors.white,
          backgroundColor: MColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
