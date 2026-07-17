import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/cart/data/models/cart_item_model.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/cubits/cart_state.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/widgets/order_summary.dart';
import 'package:nti_ecommerce_team4/features/cart/presentation/widgets/product_itme.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/widgets/custom_drawer.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        drawer: const DevDrawer(),
        appBar: AppBar(
          title: Text(
            s.appTitle,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              fontFamily: "playfairdisplay",
            ),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.shopping_bag),
            ),
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off_rounded, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text("Connection Error"),
                      const SizedBox(height: 8),
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CartCubit>().getCart(),
                        icon: const Icon(Icons.refresh),
                        label: const Text("Retry Connection"),
                      ),
                    ],
                  ),
                ),
              );
            }

            List<CartItemModel> items = [];
            double subtotal = 0;
            double discount = 0;
            double total = 0;

            if (state is CartSuccessState) {
              items = state.items;
              subtotal = state.subtotal;
              discount = state.discount;
              total = state.total;
            }

            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      s.emptyBag,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.0),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().getCart(),
                      child: Text(s.refreshBag),
                    ),
                  ],
                ),
              );
            }

            return LayoutBuilder(builder: (context, constraints) {
              final bool isWide = constraints.maxWidth > 900;
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: isWide ? 1200 : double.infinity),
                  child: isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListView(
                          padding: const EdgeInsets.all(24),
                          children: buildCartBody(context, items),
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: OrderSummary(
                            subtotal: subtotal,
                            discount: discount,
                            total: total,
                          ),
                        ),
                      ),
                    ],
                  )
                      : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ...buildCartBody(context, items),
                      const SizedBox(height: 20),
                      OrderSummary(
                        subtotal: subtotal,
                        discount: discount,
                        total: total,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  List<Widget> buildCartBody(BuildContext context, List<CartItemModel> items) {
    final s = S.of(context);
    return [
      Text(
        s.yourShoppingBag,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 16),
      ...items.map((item) => ProductItem(
        key: ValueKey(item.itemId),
        title: item.productName,
        subtitle: "${s.quantity}: ${item.quantity}",
        price: "€${item.finalPricePerUnit.toStringAsFixed(2)}",
        imageUrl: item.productCoverUrl,
        onDelete: () => context.read<CartCubit>().deleteCartItem(item.itemId),
      )),
    ];
  }
}
