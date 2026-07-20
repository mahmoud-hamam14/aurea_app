import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/core/utils/validators.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_state.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_button.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

import '../../../../core/theme/app_text_styles.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> myKey = GlobalKey();
    
    return Scaffold(
      appBar: const AuthAppbar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: myKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password",
                      style: AppTextStyles.heading1.copyWith(
                        color: Theme.of(context).textTheme.headlineMedium?.color,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Please enter your email address to receive a verification code.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const Gap(40),
                    CustomTextFormField(
                      labelText: "Email Address",
                      controller: emailController,
                      prefixIcon: Icons.email,
                      validator: (email) {
                        return Validator.validateEmail(email!);
                      },
                      suffixIcon: Icons.email,
                    ),
                    const Gap(40),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (state is ForgetSuccessState) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.verificationOTP,
                            arguments: emailController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.msg.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return CustomButton(
                            buttonText: "Next",
                            onButtonPressed: () async {
                              if (myKey.currentState!.validate()) {
                                await context.read<AuthCubit>().forgotPassword(
                                  email: emailController.text,
                                );
                              } else {
                                log("VALIDATION ERROR");
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
