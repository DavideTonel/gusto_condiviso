part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class ClearUser extends UserEvent {}

final class SetUser extends UserEvent {
  final User user;
  final UserSubscription? subscription;

  SetUser({required this.user, this.subscription});
}

final class SetSubscription extends UserEvent {
  //final UserSubscription subscription;
  final SubscriptionType subscriptionType;

  SetSubscription({required this.subscriptionType});
}
