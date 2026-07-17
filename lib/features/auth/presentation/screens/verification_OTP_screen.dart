import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/cubits/auth_state.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/auth_header.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/custom_button.dart';
import '../widgets/otp_input_section.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

class VerificationOtpScreen extends StatefulWidget {
  const VerificationOtpScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationOtpScreen> createState() => _VerificationOtpScreenState();
}

class _VerificationOtpScreenState extends State<VerificationOtpScreen> {
  String? otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(
                    title: 'Verification',
                    subtitle: 'Enter the 6-digit code sent to your email.',
                  ),
                  const Gap(40),
                  OtpInputSection(
                    onCompleted: (code) {
                      otp = code;
                    },
                    onResend: () {
                      context.read<AuthCubit>().resendOtp(email: widget.email);
                    },
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
                      } else if (state is OTPSuccessState) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.createNewPassword,
                          arguments: {
                            'email': widget.email,
                            'otp': otp!,
                          },
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
                          buttonText: 'Verify',
                          onButtonPressed: () {
                            if (otp != null && otp!.length == 6) {
                              context.read<AuthCubit>().validateOtp(
                                    email: widget.email,
                                    otp: otp!,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please enter a valid OTP")),
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
