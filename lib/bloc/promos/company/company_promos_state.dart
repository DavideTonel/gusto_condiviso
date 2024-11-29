part of 'company_promos_bloc.dart';

@immutable
sealed class CompanyPromosState {
  final List<Promo> promos;

  const CompanyPromosState({required this.promos});
}

final class CompanyPromosInitial extends CompanyPromosState {
  const CompanyPromosInitial(
    {
      super.promos = const []
    }
  );
}

final class CompanyPromosLoaded extends CompanyPromosState {
  const CompanyPromosLoaded({required super.promos});
}
