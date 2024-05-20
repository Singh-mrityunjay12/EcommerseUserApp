import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/style/spacing_style.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_divider.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: MSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  //Header
                  const MLoginHeader(),

                  //Form
                  const MLoginForm(),
                  //Divider
                  MLoginDivider(
                    dividerText: MTexts.orSignInWith.capitalize!,
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),
                  //Footer
                  const MLoginFooter()
                ],
              ))),
    );
  }
}
