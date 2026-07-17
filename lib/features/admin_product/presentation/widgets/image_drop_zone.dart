import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/theme/app_theme.dart';
import 'auto_enhance_chip.dart';
import 'dash_rect_painter.dart';

class ImageDropzone extends StatefulWidget {
  final Function(File?) onImagePicked;
  const ImageDropzone({super.key, required this.onImagePicked});

  @override
  State<ImageDropzone> createState() => _ImageDropzoneState();
}

class _ImageDropzoneState extends State<ImageDropzone> {
  File? _imageFile;
  bool enhanceOn = true;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        widget.onImagePicked(_imageFile);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _clearImage() {
    setState(() {
      _imageFile = null;
    });
    widget.onImagePicked(null);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Stack(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CustomPaint(
            painter: DashedRectPainter(
              color: AppColors.gold.withValues(alpha: 0.55),
              radius: 16,
            ),
            child: Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: textPrimary.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        _imageFile!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add_photo_alternate_rounded,
                          size: 34,
                          color: AppColors.gold,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Click to upload from gallery',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'High-resolution studio photography recommended',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (_imageFile != null) ...[
          Positioned(
            top: 10,
            right: 10,
            child: Row(
              children: [
                AutoEnhanceChip(
                  enabled: enhanceOn,
                  onTap: () => setState(() => enhanceOn = !enhanceOn),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _clearImage,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
