part of 'company_bloc.dart';

@immutable
sealed class CompanyState {
  final Company? company;

  const CompanyState({required this.company});
}

final class CompanyInitial extends CompanyState {
  const CompanyInitial(): super(company: null);
}

class CompanyLoaded extends CompanyState {
  const CompanyLoaded({required super.company});
}
