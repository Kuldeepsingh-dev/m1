import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final SharedPreferences prefs;
  final FlutterSecureStorage secure;

  StorageService(this.prefs, this.secure);

  // 🌗 Theme Handling
  Future<void> saveTheme(bool isDark) => prefs.setBool('isDark', isDark);
  bool get isDark => prefs.getBool('isDark') ?? false;

  // 🔐 Secure Storage Handling
  Future<void> saveSecure(String k, String v) => secure.write(key: k, value: v);
  Future<String?> readSecure(String k) => secure.read(key: k);

  // ✅ Add this for login session checking
  Future<bool> hasToken() async {
    final token = await readSecure('token');
    return token != null && token.isNotEmpty;
  }

  Future<void> saveLocale(String localeCode) => prefs.setString('locale', localeCode);
  String get locale => prefs.getString('locale') ?? 'en'; 
}
