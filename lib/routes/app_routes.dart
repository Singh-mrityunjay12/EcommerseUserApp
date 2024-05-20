import 'package:get/get.dart';

import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';

import 'routes.dart';

class AppRoutes {
  static final pages = [
    // GetPage(name: MRoutes.home, page: () => const HomeScreen()),
    // GetPage(name: MRoutes.store, page: () => const StoreScreen()),
    // GetPage(name: MRoutes.wishlist, page: () => const FavoriteScreen()),
    // GetPage(name: MRoutes.settings, page: () => const SettingScreen()),
    // GetPage(
    //     name: MRoutes.productReviews, page: () => const ProductReviewsScreen()),
    // GetPage(name: MRoutes.order, page: () => const OrderScreen()),
    // GetPage(name: MRoutes.checkOut, page: () => const CheckoutScreen()),
    // GetPage(name: MRoutes.userProfile, page: () => const ProfileScreen()),
    // GetPage(name: MRoutes.userAddress, page: () => const UserAdressScreen()),
    // GetPage(name: MRoutes.signUp, page: () => const SignUpScreen()),
    // GetPage(name: MRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: MRoutes.signIn, page: () => const LoginScreen()),
    // GetPage(name: MRoutes.forgetPassword, page: () => const ForgotPassword()),
    GetPage(name: MRoutes.onBoarding, page: () => const OnBoardingScreen()),

    //Add more GetPage entries as needed
  ];
}
