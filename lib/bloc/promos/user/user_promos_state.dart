part of 'user_promos_bloc.dart';

@immutable
sealed class UserPromosState {
  final List<Promo> feedPromos;
  final List<Promo> enrolledPromos;

  final String? currentPromoOneshotCode;

  const UserPromosState(
    {
      required this.feedPromos,
      required this.enrolledPromos,
      required this.currentPromoOneshotCode
    }
  );
}

final class UserPromosInitial extends UserPromosState {
  const UserPromosInitial(
    {
      super.feedPromos = const [],
      super.enrolledPromos = const [],
      super.currentPromoOneshotCode
    }
  );
}

final class UserPromosLoaded extends UserPromosState {
  const UserPromosLoaded(
    {
      required super.feedPromos,
      required super.enrolledPromos,
      super.currentPromoOneshotCode
    }
  );
}