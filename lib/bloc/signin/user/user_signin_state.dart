part of 'user_signin_bloc.dart';

@immutable
sealed class UserSigninState {}

final class UserSigninInitial extends UserSigninState {}

final class UserSigninFailure extends UserSigninState {
  final String errorMessage;

  UserSigninFailure({required this.errorMessage});
}

final class UserSigninSuccess extends UserSigninState {}
