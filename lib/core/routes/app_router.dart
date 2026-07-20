import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/screens/add_product_screen.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/screens/admin_product_management_screen.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/screens/search_page.dart';
import 'package:nti_ecommerce_team4/features/auth/data/auth_repo/auth_repo.dart';
import 'package:nti_ecommerce_team4/features/auth/data/date_source/auth_remote_data_source.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/login_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/signup_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/verification_OTP_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:nti_ecommerce_team4/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:nti_ecommerce_team4/features/products/presentation/screens/product_details_screen.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/screens/about_us_screen.dart';
import 'package:nti_ecommerce_team4/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:nti_ecommerce_team4/features/splash/presentation/screens/splash_screen.dart';
import 'package:nti_ecommerce_team4/main_screen.dart';
import 'app_routes.dart';

import 'package:nti_ecommerce_team4/features/products/presentation/screens/product_listing_screen.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/screens/cart_screen.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/screens/payment_simulation_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case AppRoutes.productDetails:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(productId: args),
          );
        }
        return _errorRoute();
      case AppRoutes.adminManagement:
        return MaterialPageRoute(builder: (_) => const AdminProductManagement());
      case AppRoutes.addProduct:
        if (args is ProductCubit) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: args,
              child: const AddProductPage(),
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const AddProductPage());
      case AppRoutes.search:
        if (args is ProductCubit) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: args,
              child: const SearchPage(),
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case AppRoutes.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case AppRoutes.verifyEmail:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => VerifyEmail(userEmail: args),
          );
        }
        return _errorRoute();
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(AuthRepo(AuthRemoteDataSource())),
            child: const ForgetPasswordScreen(),
          ),
        );
      case AppRoutes.verificationOTP:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => AuthCubit(AuthRepo(AuthRemoteDataSource())),
              child: VerificationOtpScreen(email: args),
            ),
          );
        }
        return _errorRoute();
      case AppRoutes.createNewPassword:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => AuthCubit(AuthRepo(AuthRemoteDataSource())),
              child: CreateNewPasswordScreen(
                email: args['email'],
                otp: args['otp'],
              ),
            ),
          );
        }
        return _errorRoute();
      case AppRoutes.productListing:
        return MaterialPageRoute(builder: (_) => const ProductListing());
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case AppRoutes.paymentSimulation:
        return MaterialPageRoute(builder: (_) => const PaymentSimulationScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      );
    });
  }
}
