import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/core/utils/validators.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_state.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_button.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/password_conditions.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';


class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    final GlobalKey<FormState> myKey = GlobalKey();

    return Scaffold(
      appBar: const AuthAppbar(),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: myKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/Background+Border.svg"),
                    const Gap(20),
                    Text(
                      "New Password",
                      style: AppTextStyles.heading1.copyWith(
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Create a new secure password for your account.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const Gap(40),
                    CustomTextFormField(
                      labelText: "New Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility,
                      controller: passController,
                      validator: (pass) {
                        return Validator.validatePassword(pass!);
                      },
                    ),
                    const Gap(20),
                    CustomTextFormField(
                      labelText: "Confirm Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility,
                      controller: confirmPassController,
                      validator: (pass) {
                        return Validator.validatePassword(pass!);
                      },
                    ),
                    const Gap(32),
                    const PasswordConditions(text: "At least 8 characters long"),
                    const Gap(5),
                    const PasswordConditions(text: "Contains a symbol or number"),
                    const Gap(32),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (state is NewPassSuccessState) {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
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
                            buttonText: "Update Password",
                            onButtonPressed: () {
                              if (myKey.currentState!.validate()) {
                                if (confirmPassController.text == passController.text) {
                                  context.read<AuthCubit>().resetPassword(
                                    email: email,
                                    otp: otp,
                                    newPassword: confirmPassController.text,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Passwords don't match"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
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
