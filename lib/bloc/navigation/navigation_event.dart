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

// User-Create-Recipe

final class NavigateToRecipeCreation extends NavigationEvent {}

final class NavigateToRecipeStepCreation extends NavigationEvent {}

// Teacher

final class NavigateToTeacherSignin extends NavigationEvent {}

final class NavigateToTeacherLogin extends NavigationEvent {}

final class NavigateToTeacherHomeProfileInfo extends NavigationEvent {}

final class NavigateToTeacherHomeVideoClasses extends NavigationEvent {}

final class NavigateToTeacherHomeCourses extends NavigationEvent {}

// Company

final class NavigateToCompanySignin extends NavigationEvent {}

final class NavigateToCompanyLogin extends NavigationEvent {}

final class NavigateToCompanyHomeProfileInfo extends NavigationEvent {}

final class NavigateToCompanyHomePromoCodes extends NavigationEvent {}