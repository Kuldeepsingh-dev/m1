import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:m1/core/services/service_locator.dart';
import 'package:m1/core/services/storage_service.dart';

class ThemeState extends Equatable {
  final bool isDark;
  const ThemeState({required this.isDark});
  @override
  List<Object?> get props => [isDark];
}

abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService storage = getIt<StorageService>();

  ThemeBloc() : super(ThemeState(isDark: getIt<StorageService>().isDark)) {
    on<ToggleThemeEvent>((event, emit) async {
      final newIsDark = !state.isDark;
      await storage.saveTheme(newIsDark); 
      emit(ThemeState(isDark: newIsDark));
    });
  }
}
