import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_cubit.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/cubits/product_state.dart';
import 'package:nti_ecommerce_team4/features/admin_product/presentation/widgets/add_product_list_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          autofocus: true,
          onChanged: (query) {
            context.read<ProductCubit>().searchProducts(query);
          },
        ),
      ),
      body: AddProductListview(
        onCountChanged: (_) {},
      ),
    );
  }
}
