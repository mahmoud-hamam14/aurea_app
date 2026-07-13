import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/core/utils/validators.dart';
import 'package:nti_ecommerce_team4/features/auth/data/auth_repo/auth_repo.dart';
import 'package:nti_ecommerce_team4/features/auth/data/date_source/auth_remote_data_source.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_state.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/login_screen.dart';
//import 'package:nti_ecommerce_team4/features/auth/presentation/screens/login_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_divider.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_redirect_text.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_button.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/social_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepo(AuthRemoteDataSource())),
        child: SignupScreenBody(),
      ),
    );
  }
}

class SignupScreenBody extends StatefulWidget {
  const SignupScreenBody({super.key});

  @override
  State<SignupScreenBody> createState() => _SignupScreenBodyState();
}

class _SignupScreenBodyState extends State<SignupScreenBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final GlobalKey<FormState> myKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Form(
          key: myKey,
          child: Column(
            children: [
              const Gap(5),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 120,
                width: 120,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    // color: AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.lightBorder),
                  ),
                  child: Column(
                    spacing: 14,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(8),
                      Text(
                        "Create Account",
                        style: AppTextStyles.heading1.copyWith(
                          color: AppColors.lightTextMuted,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      Text(
                        "Join the world of exquisite craftsmanship",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                      const Gap(10),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: firstNameController,
                              labelText: "Full Name",
                              validator: (firstName) {
                                return Validator.validateUserName(firstName!);
                              },
                            ),
                          ),

                          const Gap(16),

                          Expanded(
                            child: CustomTextFormField(
                              controller: lastNameController,
                              labelText: "Last Name",
                              validator: (lastName) {
                                return Validator.validateUserName(lastName!);
                              },
                            ),
                          ),
                        ],
                      ),

                      CustomTextFormField(
                        controller: emailController,
                        labelText: "Email",
                        validator: (email) {
                          return Validator.validateEmail(email!);
                        },
                      ),

                      CustomTextFormField(
                        controller: passController,
                        labelText: "Password",
                        suffixIcon: Icons.visibility,
                        validator: (password) {
                          return Validator.validatePassword(password!);
                        },
                      ),

                      CustomTextFormField(
                        controller: confirmPassController,
                        labelText: "Confirm Password",
                        suffixIcon: Icons.visibility,
                        validator: (password) {
                          return Validator.validatePassword(password!);
                        },
                      ),

                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccessState) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyEmail(
                                  userEmail: emailController.text,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Signup Successfully'),
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
                            return CustomButton(
                              buttonText: 'Create Account',
                              onButtonPressed: () {
                                if (confirmPassController.text ==
                                    passController.text) {
                                  context.read<AuthCubit>().register(
                                    data: {
                                      "firstName": firstNameController.text,
                                      "lastName": lastNameController.text,
                                      "email": emailController.text,
                                      "password": passController.text,
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Password didn't match"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                      const Gap(6),

                      const AuthDivider(dividerText: 'OR SIGN UP WITH'),

                      const Gap(12),

                      Row(
                        spacing: 30,
                        children: [
                          Expanded(
                            child: SocialButton(
                              iconPath: "assets/icons/google.svg",
                              title: "Google",
                            ),
                          ),

                          Expanded(
                            child: SocialButton(
                              iconPath: "assets/icons/apple.svg",
                              title: "Apple",
                            ),
                          ),
                        ],
                      ),
                      const Gap(6),
                      AuthRedirectText(
                        question: 'Already have an account?',
                        actionText: 'Log in',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
