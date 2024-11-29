part of 'company_signin_bloc.dart';

@immutable
sealed class CompanySigninState {}

final class CompanySigninInitial extends CompanySigninState {}

final class CompanySigninFailure extends CompanySigninState {
  final String errorMessage;

  CompanySigninFailure({required this.errorMessage});
}

final class CompanySigninSuccess extends CompanySigninState {}
