import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/add_product_list_view.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/data/date_source/product_service.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import '../../../../core/utils/app_text_styles.dart';

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => itemCount = count);
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
    final s = S.of(context);

    return BlocProvider.value(
      value: _productCubit,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, AppRoutes.addProduct, arguments: _productCubit);
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          title: Text(
            s.adminPanel,
            style: AppTextStyles.heading2.copyWith(
              color: theme.colorScheme.onSurface,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.search, arguments: _productCubit),
              icon: const Icon(Icons.search, size: 24),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 900;
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: isWide ? 1000 : double.infinity),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.inventory,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$itemCount ${s.allProducts}",
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  const SizedBox(height: 24),
                  AddProductListview(onCountChanged: _updateItemCount),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
