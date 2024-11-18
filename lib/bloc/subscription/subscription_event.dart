part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionsEvent {}

final class LoadSubscriptionTypesRequest extends SubscriptionsEvent {}
