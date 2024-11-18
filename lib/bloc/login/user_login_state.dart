part of 'user_login_bloc.dart';

@immutable
sealed class UserLoginState {}

final class UserLoginInitial extends UserLoginState {}

final class UserLoginFailure extends UserLoginState {
  final String errorMessage;

  UserLoginFailure({
    required this.errorMessage
  });
}

final class UserLoginSuccess extends UserLoginState {
  final User user;
  final UserSubscription? subscription;

  UserLoginSuccess({required this.user, this.subscription});
}
