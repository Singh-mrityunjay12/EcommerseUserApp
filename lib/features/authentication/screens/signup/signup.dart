import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/heleper_functions.dart';
import '../login/widgets/login_divider.dart';
import '../login/widgets/login_footer.dart';
import 'widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                MTexts.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),

              //Form
              SignUpForm(dark: dark),

              const SizedBox(
                height: MSizes.spaceBtwSection,
              ),
              //Divider
              MLoginDivider(dividerText: MTexts.orSignUpWith.capitalize!),
              const SizedBox(
                height: MSizes.spaceBtwInputFields,
              ),

              //Social Button(footer)

              const MLoginFooter()
            ],
          ),
        ),
      ),
    );
  }
}
