import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:m1/core/services/api_service.dart';
import 'package:m1/core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  // 1. Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  const secure = FlutterSecureStorage();

  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<FlutterSecureStorage>(secure);

  // 2. StorageService depends on prefs & secure
  getIt.registerSingleton<StorageService>(
    StorageService(getIt<SharedPreferences>(), getIt<FlutterSecureStorage>()),
  );

  // 3. Dio
  getIt.registerLazySingleton(() => Dio());


  // 4. ApiService depends on Dio
 getIt.registerLazySingleton<ApiService>(() => ApiService());


}
