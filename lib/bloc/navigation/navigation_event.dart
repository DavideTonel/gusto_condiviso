part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

// User

final class NavigateToUserSignin extends NavigationEvent {}

final class NavigateToUserLogin extends NavigationEvent {}

final class NavigateToUserHome extends NavigationEvent {}

final class NavigateToUserHomeRecipes extends NavigationEvent {}

final class NavigateToUserHomeVideoClasses extends NavigationEvent {}

final class NavigateToUserHomeCourses extends NavigationEvent {}

final class NavigateToUserHomePromoCodes extends NavigationEvent {}

final class NavigateToUserHomeSubscription extends NavigationEvent {}

final class NavigateToUserHomeProfileInfo extends NavigationEvent {}
