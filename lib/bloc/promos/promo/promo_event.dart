part of 'promo_bloc.dart';

@immutable
sealed class PromoEvent {}

final class LoadPromoRequest extends PromoEvent {
  final int id;

  LoadPromoRequest({required this.id});
}

