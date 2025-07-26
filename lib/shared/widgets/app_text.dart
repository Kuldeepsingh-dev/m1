import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final double? height;
  final double? letterSpacing;

  const AppText({
    super.key,
    required this.text,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  });

  // Convenience constructors for common use cases
  const AppText.heading1({
    super.key,
    required this.text,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyles.heading1,
       fontSize = null,
       fontWeight = null;

  const AppText.heading2({
    super.key,
    required this.text,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyles.heading2,
       fontSize = null,
       fontWeight = null;

  const AppText.body({
    super.key,
    required this.text,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyles.body,
       fontSize = null,
       fontWeight = null;

  const AppText.caption({
    super.key,
    required this.text,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyles.caption,
       fontSize = null,
       fontWeight = null;

  const AppText.button({
    super.key,
    required this.text,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.decoration,
    this.height,
    this.letterSpacing,
  }) : style = AppTextStyles.button,
       fontSize = null,
       fontWeight = null;

  @override
  Widget build(BuildContext context) {
    // Get the localized text using easy_localization
    String localizedText = text.tr();
    
    // Build the text style
    TextStyle textStyle = style ?? const TextStyle();
    
    if (color != null) {
      textStyle = textStyle.copyWith(color: color);
    }
    
    if (fontSize != null) {
      textStyle = textStyle.copyWith(fontSize: fontSize);
    }
    
    if (fontWeight != null) {
      textStyle = textStyle.copyWith(fontWeight: fontWeight);
    }
    
    if (decoration != null) {
      textStyle = textStyle.copyWith(decoration: decoration);
    }
    
    if (height != null) {
      textStyle = textStyle.copyWith(height: height);
    }
    
    if (letterSpacing != null) {
      textStyle = textStyle.copyWith(letterSpacing: letterSpacing);
    }

    return Text(
      localizedText,
      style: textStyle,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

// Convenience constructors for common use cases
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}