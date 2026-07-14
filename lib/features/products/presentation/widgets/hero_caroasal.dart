import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/product_details_screen.dart';
import 'glass_icon_button.dart';

class HeroCarousel extends StatefulWidget {
  final int bagCount;
  final VoidCallback onBack;
  final List<String> images;
  final double? height;

  const HeroCarousel({
    super.key,
    required this.bagCount,
    required this.onBack,
    required this.images,
    this.height,
  });

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _controller = PageController();
  int _page = 0;
  Timer? _auto;

  @override
  void initState() {
    super.initState();
    if (widget.images.isNotEmpty) {
      _auto = Timer.periodic(const Duration(seconds: 5), (_) {
        if (_controller.hasClients) {
          final next = (_page + 1) % widget.images.length;
          _controller.animateToPage(
            next,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _auto?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    // Responsive height: adjusts based on screen height
    final double carouselHeight = widget.height ?? (screenHeight * 0.45).clamp(300.0, 500.0);

    return SizedBox(
      height: carouselHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, i) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.images[i],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 40)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x59141210), Color(0x00141210), Color(0x8C141210)],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlassIconButton(icon: Icons.arrow_back_ios_new_rounded, onTap: widget.onBack),
                const Text(
                  'AUREA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                ),
                _buildBagIcon(),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildDots(),
          ),
        ],
      ),
    );
  }

  Widget _buildBagIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GlassIconButton(icon: Icons.shopping_bag_outlined, onTap: () {}),
        if (widget.bagCount > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(color: context.gold, borderRadius: BorderRadius.circular(10)),
              child: Text(
                '${widget.bagCount}',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.images.length, (i) {
        final active = i == _page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? context.gold : Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
