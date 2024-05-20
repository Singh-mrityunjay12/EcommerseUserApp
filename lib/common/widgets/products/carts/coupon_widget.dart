import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class MCouponCode extends StatelessWidget {
  const MCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return MRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? MColors.dark : MColors.light,
      padding: const EdgeInsets.only(
          top: MSizes.sm, bottom: MSizes.sm, right: MSizes.sm, left: MSizes.md),
      child: Row(
        children: [
          //TextField
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Have a promo code? Enter here",
                  hintStyle:
                      TextStyle(color: dark ? MColors.light : MColors.dark),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),
          //Button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      foregroundColor: dark
                          ? MColors.white.withOpacity(0.5)
                          : MColors.dark.withOpacity(0.5),
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      side: BorderSide(color: Colors.grey.withOpacity(0.1))),
                  child: const Text("Apply")))
        ],
      ),
    );
  }
}
