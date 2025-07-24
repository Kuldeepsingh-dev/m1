import 'package:flutter/material.dart';
import 'package:m1/shared/styles/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary, 
  ),
   extensions: const <ThemeExtension<dynamic>>[
    ThemeColorClass(
      headingTextColor: Color(0xFF222222),
      graphChartColor: Color(0xFF00BFAE),
    ),
  ],
  
);

final ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimary,
    secondary: AppColors.secondary,
  ),
 extensions: const <ThemeExtension<dynamic>>[
    ThemeColorClass(
      headingTextColor: Colors.white,
      graphChartColor: Color(0xFF1DE9B6),
    ),
  ],
);

class ThemeColorClass extends ThemeExtension<ThemeColorClass> {
  final Color headingTextColor;
  final Color graphChartColor;

  const ThemeColorClass({
    required this.headingTextColor,
    required this.graphChartColor,
  });

  @override
  ThemeColorClass copyWith({Color? headingTextColor, Color? graphChartColor}) {
    return ThemeColorClass(
      headingTextColor: headingTextColor ?? this.headingTextColor,
      graphChartColor: graphChartColor ?? this.graphChartColor,
    );
  }

  @override
  ThemeColorClass lerp(ThemeExtension<ThemeColorClass>? other, double t) {
    if (other is! ThemeColorClass) return this;
    return ThemeColorClass(
      headingTextColor: Color.lerp(headingTextColor, other.headingTextColor, t)!,
      graphChartColor: Color.lerp(graphChartColor, other.graphChartColor, t)!,
    );
  }
}
