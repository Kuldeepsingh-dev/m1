import 'package:flutter/material.dart';

class KeyboardUtils {
  /// Closes the keyboard by unfocusing the current focus node.
  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Opens the keyboard for the given [FocusNode].
  static void openKeyboard(FocusNode focusNode) {
    focusNode.requestFocus();
  }
} 