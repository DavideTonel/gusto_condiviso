part of 'user_promos_bloc.dart';

@immutable
sealed class UserPromosEvent {}

final class LoadPromosForUserRequest extends UserPromosEvent {}

final class LoadPromosActivatedByUser extends UserPromosEvent {
  final String userId;

  LoadPromosActivatedByUser({required this.userId});
}

final class ActivatePromoRequest extends UserPromosEvent {
  final String userId;
  final int promoId;

  ActivatePromoRequest(
    {
      required this.userId,
      required this.promoId
    }
  );
}

final class GetSingleUseCode extends UserPromosEvent {
  final String userId;
  final int promoId;

  GetSingleUseCode(
    {
      required this.userId,
      required this.promoId
    }
  );
}

final class ClearCurrentOneshotCode extends UserPromosEvent {}
