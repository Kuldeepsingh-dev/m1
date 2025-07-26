import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:m1/core/bloc/locale_bloc.dart';
import 'package:m1/core/bloc/theme_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/config/theme.dart';
import 'core/routing/router.dart';
import 'package:m1/core/services/storage_service.dart';
import 'core/config/env.dart';
import 'core/bloc/app_bloc_providers.dart';
import 'shared/widgets/error_screen.dart';
import 'core/services/device_info_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/locale.dart'; 
// import 'core/firebase/firebase_notifications.dart';

Future<void> mainCommon({required AppEnvironment env}) async {
  Env.setEnvironment(env); 
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupServiceLocator();
  

  // Initialize Firebase Notifications
  // final firebaseNotification = FirebaseNotificationService();
  // await FirebaseNotificationService.init();
  // getIt.registerSingleton<FirebaseNotificationService>(firebaseNotification);

  // Initialize and register DeviceInfoService
  final deviceInfoService = DeviceInfoService();
  await deviceInfoService.init();
  getIt.registerSingleton<DeviceInfoService>(deviceInfoService);

  if (env == AppEnvironment.production) {
    ErrorWidget.builder = (FlutterErrorDetails details) =>
        ErrorScreen(errorDetails: details);
  }

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: defaultLocale,
      child: ScreenUtilInit(
        designSize: const Size(375, 812), 
        minTextAdapt: true,
        builder: (context, child) => MultiBlocProvider(
          providers: appBlocProviders,
          child: MyApp(env: env),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppEnvironment env;
  const MyApp({super.key, required this.env});

  bool get isDark => getIt<StorageService>().isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
              locale: localeState.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              routerConfig: router,
              debugShowCheckedModeBanner: env != AppEnvironment.production,
            );
          },
        );
      },
    );
  }
} 