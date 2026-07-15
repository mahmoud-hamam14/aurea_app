import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/offers_cubit/offers_cubit.dart';
import 'package:nti_ecommerce_team4/features/home/presentation/cubits/offers_cubit/offers_states.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({super.key, required this.onShopNow});
  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersStates>(
      builder: (context, state) {
        if (state is OffersLoadingState) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is OffersFailiurState) {
          return const SizedBox(
            height: 300,
            child: Center(child: Text("Something went wrong")),
          );
        } else if (state is OffersSuccessState) {
          if (state.offers.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(child: Text("No offers available")),
            );
          }

          return CarouselSlider(
            items: state.offers.map((offer) {
              return SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.network(
                      offer.coverul,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/beso.jpg",
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 65),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.4,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            offer.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.96,
                              color: Color(0xffFFFFFF),
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: onShopNow,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffD4AF37),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff554300),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              enlargeCenterPage: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              viewportFraction: 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollPhysics: const BouncingScrollPhysics(),
              enableInfiniteScroll: true,
            ),
          );
        } else {
          return const SizedBox(height: 300);
        }
      },
    );
  }
}
