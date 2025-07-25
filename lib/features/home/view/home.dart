import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m1/core/bloc/locale_bloc.dart';
import 'package:m1/core/bloc/theme_bloc.dart';
import 'package:m1/shared/constants/app_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Home Screen!', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 32.h),
            ElevatedButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
                child: const Text('Toggle Theme'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<LocaleBloc>().add(CycleLocaleEvent());
                },
                child: Text(AppLocalizations.of(context)!.loginTitle),
              ),
          ],
        ),
      ),
    );
  }
}