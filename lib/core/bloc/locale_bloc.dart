import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:m1/core/services/service_locator.dart';
import 'package:m1/core/services/storage_service.dart';

class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState({required this.locale});
  @override
  List<Object?> get props => [locale];
}

abstract class LocaleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CycleLocaleEvent extends LocaleEvent {}
class SetLocaleEvent extends LocaleEvent {
  final Locale locale;
  SetLocaleEvent(this.locale);
  @override
  List<Object?> get props => [locale];
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final List<Locale> supportedLocales = [const Locale('en'), const Locale('hi')];
  final StorageService storage = getIt<StorageService>();

  LocaleBloc()
      : super(LocaleState(
            locale: Locale(getIt<StorageService>().locale))) {
    on<CycleLocaleEvent>((event, emit) {
      final currentIndex = supportedLocales.indexOf(state.locale);
      final nextIndex = (currentIndex + 1) % supportedLocales.length;
      final newLocale = supportedLocales[nextIndex];
      storage.saveLocale(newLocale.languageCode); // Persist the new value
      emit(LocaleState(locale: newLocale));
    });

    on<SetLocaleEvent>((event, emit) {
      storage.saveLocale(event.locale.languageCode); // Persist the new value
      emit(LocaleState(locale: event.locale));
    });
  }
}
