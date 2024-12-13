part of 'admin_login_bloc.dart';

@immutable
sealed class AdminLoginState {}

final class AdminLoginInitial extends AdminLoginState {}

final class AdminLoginFailure extends AdminLoginState {
  final String errorMessage;

  AdminLoginFailure({
    required this.errorMessage
  });
}

final class AdminLoginSuccess extends AdminLoginState {
  final Admin admin;

  AdminLoginSuccess({required this.admin});
}
