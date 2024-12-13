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

// User-Create-Recipe

final class NavigationRecipeCreation extends NavigationState {}

final class NavigationRecipeStepCreation extends NavigationState {}

// Teacher

final class NavigationTeacherSignin extends NavigationState {}

final class NavigationTeacherLogin extends NavigationState {}

final class NavigationTeacherHomeProfileInfo extends NavigationState {}

final class NavigationTeacherHomeVideoClasses extends NavigationState {}

final class NavigationTeacherHomeCourses extends NavigationState {}

// Company

final class NavigationCompanySignin extends NavigationState {}

final class NavigationCompanyLogin extends NavigationState {}

final class NavigationCompanyHomeProfileInfo extends NavigationState {}

final class NavigationCompanyHomePromoCodes extends NavigationState {}

// Admin

final class NavigationAdminLogin extends NavigationState {}

final class NavigationAdminHomeProfileInfo extends NavigationState {}

final class NavigationAdminHomeRecipeCategories extends NavigationState {}

final class NavigationAdminHomeIngredients extends NavigationState {}

final class NavigationAdminHomeTools extends NavigationState {}

final class NavigationAdminHomeStatistics extends NavigationState {}