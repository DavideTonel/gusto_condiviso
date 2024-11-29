part of 'company_promos_bloc.dart';

@immutable
sealed class CompanyPromosEvent {}

final class LoadPromosMadeByCompanyRequest extends CompanyPromosEvent {
  final String companyId;

  LoadPromosMadeByCompanyRequest({required this.companyId});
}

final class SavePromoRequest extends CompanyPromosEvent {
  final String companyId;
  final String name;
  final String endDate;
  final String description;
  final String useInstructions;

  SavePromoRequest(
    {
      required this.companyId,
      required this.name,
      required this.endDate,
      required this.description,
      required this.useInstructions
    }
  );
}
