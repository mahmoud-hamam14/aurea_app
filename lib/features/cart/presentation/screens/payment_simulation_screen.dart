import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

import '../../../../core/utils/app_colors.dart';

class PaymentSimulationScreen extends StatefulWidget {
  const PaymentSimulationScreen({super.key});

  @override
  State<PaymentSimulationScreen> createState() => _PaymentSimulationScreenState();
}

class _PaymentSimulationScreenState extends State<PaymentSimulationScreen> {
  bool _isProcessing = false;

  void _simulatePayment() {
    setState(() => _isProcessing = true);
    

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        _showSuccessDialog();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Payment Successful",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Text(
              "Your order has been placed successfully. Thank you for shopping with AUREA.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Back to Cart or Home
              },
              child: const Text("Back to Shop"),
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Checkout"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.payment_rounded, size: 80, color: AppColors.gold),
              const Gap(24),
              Text(
                "Payment Simulation",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              const Text(
                "This is a safe environment to simulate your transaction. No real money will be charged.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Gap(40),
              
              // Card Details Mockup
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.credit_card, color: AppColors.gold),
                        const Gap(12),
                        Text("**** **** **** 4242", style: theme.textTheme.bodyLarge),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount to Pay:", style: theme.textTheme.bodyMedium),
                        const Text("€6,660.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Gap(48),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _simulatePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "PAY NOW",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                ),
              ),
              const Gap(20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel and Return"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
