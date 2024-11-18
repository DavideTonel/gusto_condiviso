part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionsState {
  final List<SubscriptionType> subscriptionTypes;

  const SubscriptionsState({required this.subscriptionTypes});
}

final class SubscriptionInitial extends SubscriptionsState {
  SubscriptionInitial(): super(subscriptionTypes: List.empty());
}

final class SubscriptionsTypeLoaded extends SubscriptionsState {
  const SubscriptionsTypeLoaded({required super.subscriptionTypes});
}
