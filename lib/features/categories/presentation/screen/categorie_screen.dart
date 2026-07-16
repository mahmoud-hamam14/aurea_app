import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';
import 'package:nti_ecommerce_team4/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:nti_ecommerce_team4/features/categories/presentation/widgets/collections_gridview.dart';
import 'package:nti_ecommerce_team4/features/categories/presentation/widgets/textfield.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/custom_drawer.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      drawer: const DevDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 158, 125, 16),
        ),
        title: Text(
          s.appTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color.fromARGB(255, 158, 125, 16),
                fontFamily: 'PlayfairDisplay',
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined, size: 28),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 900;
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isWide ? 1200 : double.infinity),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  s.collections,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 15),
                Textfield(icon: Icons.search, hint: s.searchArchives),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocProvider(
                    create: (context) => CategoriesCubit()..getCategories(),
                    child: const CollectionsGridView(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
