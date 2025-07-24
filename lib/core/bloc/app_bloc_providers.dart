import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m1/core/bloc/locale_bloc.dart';
import 'package:m1/core/bloc/theme_bloc.dart';


// import other blocs as needed

final List<BlocProvider> appBlocProviders = [
  BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
  BlocProvider<LocaleBloc>(create: (_) => LocaleBloc()),
  // Add more BlocProviders here as needed
];