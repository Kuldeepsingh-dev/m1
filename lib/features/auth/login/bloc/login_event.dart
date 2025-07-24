import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final String deviceToken;

  LoginSubmitted({required this.email, required this.password, required this.deviceToken});

  @override
  List<Object?> get props => [email, password, deviceToken];
} 