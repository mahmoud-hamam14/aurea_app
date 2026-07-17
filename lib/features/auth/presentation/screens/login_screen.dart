import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/core/utils/validators.dart';
import 'package:nti_ecommerce_team4/features/auth/data/auth_repo/auth_repo.dart';
import 'package:nti_ecommerce_team4/features/auth/data/date_source/auth_remote_data_source.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_state.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_header.dart';
import 'package:gap/gap.dart';
import '../widgets/auth_redirect_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/social_auth_section.dart';

import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepo(AuthRemoteDataSource())),
        child: const LoginScreenBody(),
      ),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(
      child: SingleChildScrollView(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth > 600;
              return Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: myKey,
                  child: Column(
                    children: [
                      const Gap(50),
                      //* AuthHeader
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 130,
                        width: 130,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: isWide ? 0 : 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.lightBorder),
                        ),
                        child: Column(
                          children: [
                            const Gap(25),
                            AuthHeader(
                              title: s.welcomeBack,
                              subtitle: s.signinSubtitle,
                            ),
                            const Gap(25),

                            //* Email TextFormField
                            CustomTextFormField(
                              controller: emailController,
                              labelText: s.email,
                              prefixIcon: Icons.email,
                              validator: (email) {
                                return Validator.validateEmail(email!);
                              },
                              suffixIcon: Icons.email,
                            ),

                            const Gap(25),

                            //* Password TextFormField
                            CustomTextFormField(
                              controller: passwordController,
                              labelText: s.password,
                              prefixIcon: Icons.lock,
                              suffixIcon: Icons.visibility,
                              validator: (password) {
                                return Validator.validatePassword(password!);
                              },
                            ),
                            const Gap(5),

                            //* Forget Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.forgetPassword);
                                },
                                child: Text(
                                  s.forgotPassword,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),

                            const Gap(25),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccessState) {
                                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Welcome back'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                                if (state is AuthErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  //* Login Button
                                  return CustomButton(
                                    buttonText: s.login,
                                    onButtonPressed: () {
                                      if (myKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                      }
                                    },
                                  );
                                }
                              },
                            ),

                            const Gap(25),

                            //* Alternative Login Options
                            AuthDivider(dividerText: s.orContinueWith),

                            const Gap(25),

                            //* Social Auth Section
                            const SocialAuthSection(),

                            const Gap(25),

                            //* Dont have an account
                            AuthRedirectText(
                              question: s.dontHaveAccount,
                              actionText: s.signup,
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.signup);
                              },
                            ),

                            const Gap(30),
                          ],
                        ),
                      ),
                      const Gap(50),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
