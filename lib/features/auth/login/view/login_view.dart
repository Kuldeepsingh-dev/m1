import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m1/features/auth/login/bloc/login_bloc.dart';
import 'package:m1/features/auth/login/bloc/login_event.dart';
import 'package:m1/features/auth/login/bloc/login_state.dart';
import 'package:m1/shared/widgets/loading_widget.dart';
import 'package:m1/core/utils/ui_helpers.dart';
import 'package:m1/shared/constants/app_strings.dart';
import 'package:go_router/go_router.dart';
import 'package:m1/core/routing/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            UIHelpers.showSnackbar(context, state.error);
          }
          if (state is LoginSuccess) {
            UIHelpers.showSnackbar(context, AppStrings.loginSuccess);
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.loginTitle)),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: AppStrings.emailLabel),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: AppStrings.passwordLabel),
                    obscureText: true,
                  ),
                  SizedBox(height: 24.h),
                  state is LoginLoading
                      ? const LoadingWidget()
                      : ElevatedButton(
                          onPressed: () {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            const deviceToken = 'dummy_token';
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    email: email,
                                    password: password,
                                    deviceToken: deviceToken,
                                  ),
                                );
                          },
                          child: const Text(AppStrings.loginButton),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 