part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

// User

final class NavigationUserSignin extends NavigationState {}

final class NavigationUserLogin extends NavigationState {}

//final class NavigationUserHome extends NavigationState {}

final class NavigationUserHomeRecipes extends NavigationState {}

final class NavigationUserHomeVideoClasses extends NavigationState {}

final class NavigationUserHomeCourses extends NavigationState {}

final class NavigationUserHomePromoCodes extends NavigationState {}

final class NavigationUserHomeSubscription extends NavigationState {}

final class NavigationUserHomeProfileInfo extends NavigationState {}
