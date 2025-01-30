part of 'user_bloc.dart';

@immutable
sealed class UserState {
  final User? user;
  final List<UserSubscription> pastSubscriptions;

  const UserState(
    {
      required this.user,
      required this.pastSubscriptions
    }
  );
}

final class UserInitial extends UserState {
  const UserInitial(
    {
      super.user,
      super.pastSubscriptions = const []
    }
  );
}

class UserLoaded extends UserState {
  const UserLoaded(
    {
      required super.user,
      required super.pastSubscriptions
    }
  );
}
