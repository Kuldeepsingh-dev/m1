class Validators {
  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value, {String message = 'Enter a valid email'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  static String? password(String? value, {String message = 'Password must be at least 6 characters'}) {
    if (value == null || value.length < 6) {
      return message;
    }
    return null;
  }

  // Add more validators as needed
} 