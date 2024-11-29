part of 'company_login_bloc.dart';

@immutable
sealed class CompanyLoginState {}

final class CompanyLoginInitial extends CompanyLoginState {}

final class CompanyLoginFailure extends CompanyLoginState {
  final String errorMessage;

  CompanyLoginFailure({
    required this.errorMessage
  });
}

final class CompanyLoginSuccess extends CompanyLoginState {
  final Company company;

  CompanyLoginSuccess({required this.company});
}
