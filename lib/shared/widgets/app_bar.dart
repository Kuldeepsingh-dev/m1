import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showDrawer;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final Widget? customLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.showDrawer = false,
    this.actions,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.customLeading,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (customLeading != null) {
      leadingWidget = customLeading;
    } else if (showBackButton) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).maybePop(),
      );
    } else if (showDrawer) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }

    return CustomAppBar(
      title: title,
      backgroundColor: backgroundColor,
      elevation: elevation,
      customLeading: leadingWidget,
      actions: actions,
    );
  }
}
