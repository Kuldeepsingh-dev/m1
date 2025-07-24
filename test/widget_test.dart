// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:m1/core/services/service_locator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:m1/features/auth/login/bloc/login_bloc.dart';
import 'package:m1/features/auth/login/bloc/login_event.dart';
import 'package:m1/features/auth/login/bloc/login_state.dart';
import 'package:m1/core/services/api_service.dart';
import 'package:m1/core/services/device_info_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockApiService extends Mock implements ApiService {}
class MockDeviceInfoService extends Mock implements DeviceInfoService {}

void main() {
  late MockApiService mockApiService;
  late MockDeviceInfoService mockDeviceInfoService;
  late LoginBloc loginBloc;

  setUp(() {
    getIt.reset();
    mockApiService = MockApiService();
    mockDeviceInfoService = MockDeviceInfoService();
    getIt.registerSingleton<ApiService>(mockApiService);
    getIt.registerSingleton<DeviceInfoService>(mockDeviceInfoService);
    loginBloc = LoginBloc();
  });

  group('LoginBloc', () {
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () {
        when(() => mockDeviceInfoService.deviceModel).thenReturn('Pixel 4');
        when(() => mockApiService.post(any(), any())).thenAnswer(
          (_) async => Response(
            data: {'token': 'abc123'},
            requestOptions: RequestOptions(path: ''),
          ),
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'test@example.com',
        password: 'password',
        deviceToken: 'token123',
      )),
      expect: () => [
        LoginLoading(),
        isA<LoginSuccess>(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () {
        when(() => mockDeviceInfoService.deviceModel).thenReturn('Pixel 4');
        when(() => mockApiService.post(any(), any())).thenThrow(Exception('error'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginSubmitted(
        email: 'test@example.com',
        password: 'password',
        deviceToken: 'token123',
      )),
      expect: () => [
        LoginLoading(),
        isA<LoginFailure>(),
      ],
    );
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
