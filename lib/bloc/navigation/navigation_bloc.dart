import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {


    // User

    on<NavigateToUserSignin>((event, emit) => emit(NavigationUserSignin()));

    on<NavigateToUserLogin>((event, emit) => emit(NavigationUserLogin()));

    on<NavigateToUserHomeRecipes>((event, emit) => emit(NavigationUserHomeRecipes()));

    on<NavigateToUserHomeVideoClasses>((event, emit) => emit(NavigationUserHomeVideoClasses()));

    on<NavigateToUserHomeCourses>((event, emit) => emit(NavigationUserHomeCourses()));

    on<NavigateToUserHomePromoCodes>((event, emit) => emit(NavigationUserHomePromoCodes()));

    on<NavigateToUserHomeSubscription>((event, emit) => emit(NavigationUserHomeSubscription()));

    on<NavigateToUserHomeProfileInfo>((event, emit) => emit(NavigationUserHomeProfileInfo()));

    // User-Create-Recipe

    on<NavigateToRecipeCreation>((event, emit) => emit(NavigationRecipeCreation()));

    on<NavigateToRecipeStepCreation>((event, emit) => emit(NavigationRecipeStepCreation()));

    // Teacher

    on<NavigateToTeacherSignin>((event, emit) => emit(NavigationTeacherSignin()));

    on<NavigateToTeacherLogin>((event, emit) => emit(NavigationTeacherLogin()));

    on<NavigateToTeacherHomeProfileInfo>((event, emit) => emit(NavigationTeacherHomeProfileInfo()));

    on<NavigateToTeacherHomeVideoClasses>((event, emit) => emit(NavigationTeacherHomeVideoClasses()));

    on<NavigateToTeacherHomeCourses>((event, emit) => emit(NavigationTeacherHomeCourses()));

    // Company

    on<NavigateToCompanySignin>((event, emit) => emit(NavigationCompanySignin()));

    on<NavigateToCompanyLogin>((event, emit) => emit(NavigationCompanyLogin()));

    on<NavigateToCompanyHomeProfileInfo>((event, emit) => emit(NavigationCompanyHomeProfileInfo()));

    on<NavigateToCompanyHomePromoCodes>((event, emit) => emit(NavigationCompanyHomePromoCodes()));

    // Admin

    on<NavigateToAdminLogin>((event, emit) => emit(NavigationAdminLogin()));

    on<NavigateToAdminHomeProfileInfo>((event, emit) => emit(NavigationAdminHomeProfileInfo()));

    on<NavigateToAdminHomeRecipeCategories>((event, emit) => emit(NavigationAdminHomeRecipeCategories()));

    on<NavigateToAdminHomeIngredients>((event, emit) => emit(NavigationAdminHomeIngredients()));

    on<NavigateToAdminHomeTools>((event, emit) => emit(NavigationAdminHomeTools()));

    on<NavigateToAdminHomeStatistics>((event, emit) => emit(NavigationAdminHomeStatistics()));
  }
}
