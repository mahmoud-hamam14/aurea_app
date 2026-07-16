import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/add_product_app_bar.dart';
import '../widgets/aurea_text_area.dart';
import '../widgets/aurea_text_field.dart';
import '../widgets/image_drop_zone.dart';
import '../widgets/section_card.dart';
import '../../data/models/product_model.dart';
import '../cubits/product_cubit.dart';
import '../cubits/product_state.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final sellerId = TextEditingController(text: "d051dbf3-f5d8-410d-0e50-08de06562562");
  final nameEn = TextEditingController();
  final nameAr = TextEditingController();
  final price = TextEditingController();
  final stock = TextEditingController(text: '10');
  final color = TextEditingController(text: 'Gold');
  final descEn = TextEditingController();
  final descAr = TextEditingController();

  File? _pickedImage;
  bool _isSaving = false;

  @override
  void dispose() {
    for (final c in [sellerId, nameEn, nameAr, price, stock, color, descEn, descAr]) {
      c.dispose();
    }
    super.dispose();
  }

  void _onSavePressed() {
    final s = S.of(context);
    if (nameEn.text.isEmpty || price.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and Price are required")),
      );
      return;
    }
    
    if (_pickedImage == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a product image")),
      );
      return;
    }

    setState(() => _isSaving = true);
    
    final product = ProductModel(
      sellerId: sellerId.text,
      name: nameEn.text,
      nameArabic: nameAr.text,
      price: int.tryParse(price.text),
      stock: int.tryParse(stock.text),
      color: color.text,
      description: descEn.text,
      descriptionArabic: descAr.text,
      coverPictureUrl: "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908",
    );
    
    context.read<ProductCubit>().addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.saveProduct), 
              backgroundColor: Colors.green
            ),
          );
          Navigator.pop(context);
        } else if (state is ProductError) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AddProductAppBar(onClose: () => Navigator.maybePop(context)),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWide = constraints.maxWidth > 900;
                    
                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24),
                              child: SectionCard(
                                title: s.saveProduct, // Simplified
                                child: ImageDropzone(
                                  onImagePicked: (file) {
                                    setState(() => _pickedImage = file);
                                  },
                                )
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24),
                              child: _buildForm(isDark, s),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionCard(
                              title: s.saveProduct, // Simplified
                              child: ImageDropzone(
                                onImagePicked: (file) {
                                  setState(() => _pickedImage = file);
                                },
                              )
                            ),
                            const SizedBox(height: 16),
                            _buildForm(isDark, s),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isDark, S s) {
    return Column(
      children: [
        SectionCard(
          title: s.accountSettings, // Simplified or Basic Info if added to l10n
          child: Column(
            children: [
              AureaTextField(label: s.productName, hint: 'e.g. Aurelia...', controller: nameEn),
              const SizedBox(height: 14),
              AureaTextField(label: s.arabicName, hint: 'اسم المنتج', controller: nameAr, rtl: true),
              const SizedBox(height: 14),
              AureaTextField(label: '${s.price} (SAR)', hint: '0.00', controller: price, keyboardType: TextInputType.number, suffix: 'SAR'),
              const SizedBox(height: 14),
              AureaTextField(label: s.stock, hint: '1', controller: stock, keyboardType: TextInputType.number),
              const SizedBox(height: 14),
              AureaTextField(label: s.color, hint: 'e.g. 18K Yellow Gold', controller: color),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: s.description,
          child: Column(
            children: [
              AureaTextArea(label: s.description, hint: 'Describe the craftsmanship...', controller: descEn),
              const SizedBox(height: 14),
              AureaTextArea(label: s.arabicDescription, hint: 'وصف المنتج...', controller: descAr, rtl: true),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _isSaving ? null : _onSavePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              disabledBackgroundColor: AppColors.gold.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: _isSaving 
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  s.saveProduct,
                  style: AppTextStyles.buttonText.copyWith(
                    color: isDark ? AppColors.darkBackground : AppColors.white
                  )
                ),
          ),
        ),
      ],
    );
  }
}
