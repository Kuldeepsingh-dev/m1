import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/config/locale.dart'; 

Future<void> mainCommon({required AppEnvironment env}) async {
  Env.setEnvironment(env); 
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  // Initialize and register DeviceInfoService
  final deviceInfoService = DeviceInfoService();
  await deviceInfoService.init();
  getIt.registerSingleton<DeviceInfoService>(deviceInfoService);

  if (env == AppEnvironment.production) {
    ErrorWidget.builder = (FlutterErrorDetails details) =>
        CustomErrorScreen(errorDetails: details);
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: appBlocProviders, // or your list of providers
        child: MyApp(env: env),
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
              supportedLocales: supportedLocales, 
              localizationsDelegates: const [ 
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerConfig: router,
              debugShowCheckedModeBanner: env != AppEnvironment.production,
            );
          },
        );
      },
    );
  }
} 