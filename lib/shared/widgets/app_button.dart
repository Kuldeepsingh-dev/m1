import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final String? textKey;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final TextStyle? textStyle;
  final bool fullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    this.text,
    this.textKey,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.textStyle,
    this.fullWidth = true,
    this.icon,
  }) : assert(
         text != null || textKey != null,
         'Either text or textKey must be provided'
       );

  @override
  Widget build(BuildContext context) {
    // Get the button text (localized or direct)
    final buttonText = textKey?.tr() ?? text ?? '';
    
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    buttonText,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
