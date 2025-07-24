import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m1/core/services/apis.dart';
import 'package:m1/core/services/service_locator.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:m1/core/services/api_service.dart';
import 'package:m1/core/services/device_info_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService = getIt<ApiService>();
  final DeviceInfoService deviceInfo = getIt<DeviceInfoService>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final data = {
          "email": event.email,
          "password": event.password,
          "device_token": event.deviceToken,
          "device_type": deviceInfo.deviceModel ?? "Unknown"
        };
        final response = await apiService.post(Apis.login, data);
        emit(LoginSuccess(response.data));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
} 