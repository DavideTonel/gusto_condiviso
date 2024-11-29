part of 'promo_bloc.dart';

@immutable
sealed class PromoState {
  final Promo? promo;

  const PromoState({required this.promo});
}

final class PromoInitial extends PromoState {
  const PromoInitial(
    {
      super.promo
    }
  );
}

final class PromoLoaded extends PromoState {
  const PromoLoaded(
    {
      required super.promo
    }
  );
}