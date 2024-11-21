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
  }
}
