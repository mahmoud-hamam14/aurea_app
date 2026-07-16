import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/data/date_source/cart_get_data.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/add_to_cart_cubit.dart';
import 'package:nti_ecommerce_team4/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/offers_cubit/offers_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/all_product_gridview.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/custom_drawer.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/explore_listview.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/offer_section.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey collectionsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OffersCubit()..getOffers()),
        BlocProvider(create: (context) => ProductsCubit()..getProducts()),
        BlocProvider(create: (context) => AddToCartCubit(CartRemoteDataSource())),
      ],
      child: Scaffold(
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
              icon: const Icon(Icons.search, size: 28),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined, size: 28),
                ),
                Positioned(
                  right: 6,
                  top: 8,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4AF37),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            final bool isWide = constraints.maxWidth > 900;
            return Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: isWide ? 1200 : double.infinity),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: OfferSection(
                          onShopNow: () {
                            if (collectionsKey.currentContext != null) {
                              Scrollable.ensureVisible(
                                collectionsKey.currentContext!,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.explore,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocProvider(
                            create: (context) => CategoriesCubit()..getCategories(),
                            child: const SizedBox(height: 120, child: ExploreListView()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.allProducts,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                          const SizedBox(height: 24),
                          AllProductGridView(key: collectionsKey),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
