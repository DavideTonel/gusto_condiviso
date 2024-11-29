part of 'company_bloc.dart';

@immutable
sealed class CompanyEvent {}

final class SetCompany extends CompanyEvent {
  final Company company;

  SetCompany({required this.company});
}
