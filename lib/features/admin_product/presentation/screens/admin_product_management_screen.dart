import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/screens/search_page.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/add_product_list_view.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/data/date_source/product_service.dart';

import 'add_product_screen.dart';

import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';

class AdminProductManagement extends StatefulWidget {
  const AdminProductManagement({super.key});

  @override
  State<AdminProductManagement> createState() => _AdminProductManagementState();
}

class _AdminProductManagementState extends State<AdminProductManagement> {
  int itemCount = 0;
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = ProductCubit(ProductService())..loadProducts();
  }

  void _updateItemCount(int count) {
    if (itemCount != count) {
      // Using PostFrameCallback to avoid setstate during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            itemCount = count;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: _productCubit,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              AppRoutes.addProduct,
              arguments: _productCubit,
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          title: Text(
            'Products',
            style: AppTextStyles.heading2.copyWith(
              color: theme.colorScheme.onSurface,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.search,
                  arguments: _productCubit,
                );
              },
              icon: const Icon(Icons.search, size: 24),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined, size: 24),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INVENTORY",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  "$itemCount Items",
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                const SizedBox(height: 16),
                AddProductListview(
                  onCountChanged: _updateItemCount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
