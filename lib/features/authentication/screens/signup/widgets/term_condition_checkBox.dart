import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../controller/signup/signup_controller.dart';

class TermConditionCheckBox extends StatelessWidget {
  const TermConditionCheckBox({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(() => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value)),
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${MTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${MTexts.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? MColors.white : MColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? MColors.white : MColors.primary,
                  )),
          TextSpan(
              text: '${MTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: MTexts.termOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? MColors.white : MColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? MColors.white : MColors.primary,
                  )),
        ]))
      ],
    );
  }
}
