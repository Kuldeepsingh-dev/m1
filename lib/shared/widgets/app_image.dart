import 'dart:ui';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final String? placeholderAsset;
  final Widget? errorWidget;

  const AppImage({
    Key? key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.placeholderAsset,
    this.errorWidget,
  }) : super(key: key);

  bool get isNetwork => imagePath.startsWith('http') || imagePath.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: isNetwork
          ? Stack(
              alignment: Alignment.center,
              children: [
                // Blurred Placeholder
                if (placeholderAsset != null)
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Image.asset(
                      placeholderAsset!,
                      width: width,
                      height: height,
                      fit: fit,
                    ),
                  )
                else
                  Container(
                    width: width,
                    height: height,
                    color: Colors.grey.shade300,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: const SizedBox(),
                    ),
                  ),

                // Network Image
                Image.network(
                  imagePath,
                  width: width,
                  height: height,
                  fit: fit,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(); // Keep blur underneath
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return errorWidget ??
                        const Icon(Icons.broken_image, size: 40, color: Colors.grey);
                  },
                ),
              ],
            )
          : Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ??
                    const Icon(Icons.broken_image, size: 40, color: Colors.grey);
              },
            ),
    );
  }
}
