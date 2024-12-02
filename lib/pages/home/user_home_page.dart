import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/user/user_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/user/user_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/subscription/subscription_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/user/user_video_classes_bloc.dart';
import 'package:gusto_condiviso/pages/courses/user/user_courses_feed_page.dart';
import 'package:gusto_condiviso/pages/profiles/user_profile_page.dart';
import 'package:gusto_condiviso/pages/promos/user/user_promos_feed_page.dart';
import 'package:gusto_condiviso/pages/recipes/recipes_feed_page.dart';
import 'package:gusto_condiviso/pages/subscriptions/user_subscription_page.dart';
import 'package:gusto_condiviso/pages/video_classes/user/user_video_classes_feed_page.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationRailIndex = 0;

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        switch (state) {
          case NavigationUserHomeProfileInfo _: {
            navigationRailIndex = 0;
          }
          case NavigationUserHomeSubscription _: {
            navigationRailIndex = 1;
          }
          case NavigationUserHomeRecipes _: {
            navigationRailIndex = 2;
          }
          case NavigationUserHomeVideoClasses _: {
            navigationRailIndex = 3;
          }
          case NavigationUserHomeCourses _: {
            navigationRailIndex = 4;
          }
          case NavigationUserHomePromoCodes _: {
            navigationRailIndex = 5;
          }
          default: {
            navigationRailIndex = 0;
          }
        }
      },
      builder: (context, state) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NavigationRail(
                      selectedIndex: navigationRailIndex,
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        const NavigationRailDestination(
                          selectedIcon: Icon(Icons.account_circle),
                          icon: Icon(Icons.account_circle_outlined),
                          label: Text("Profilo")
                        ),
                        const NavigationRailDestination(
                          selectedIcon: Icon(Icons.subscriptions),
                          icon: Icon(Icons.subscriptions_outlined),
                          label: Text("Abbonamento")
                        ),
                        NavigationRailDestination(
                          selectedIcon: const Icon(Icons.feed),
                          icon: const Icon(Icons.feed_outlined),
                          label: const Text("Ricette"),
                          disabled: state.user!.subscription?.subscriptionType.name != "Free" && state.user!.subscription?.subscriptionType.name != "Silver" && state.user!.subscription?.subscriptionType.name != "Gold"
                        ),
                        NavigationRailDestination(
                          selectedIcon: const Icon(Icons.featured_video),
                          icon: const Icon(Icons.featured_video_outlined),
                          label: const Text("Lezioni"),
                          disabled: state.user!.subscription?.subscriptionType.name != "Silver" && state.user!.subscription?.subscriptionType.name != "Gold"
                        ),
                        NavigationRailDestination(
                          selectedIcon: const Icon(Icons.class_),
                          icon: const Icon(Icons.class_outlined),
                          label: const Text("Corsi"),
                          disabled: state.user!.subscription?.subscriptionType.name != "Gold"
                        ),
                        NavigationRailDestination(
                          selectedIcon: const Icon(Icons.card_giftcard),
                          icon: const Icon(Icons.card_giftcard_outlined),
                          label: const Text("Promozioni"),
                          disabled: state.user!.subscription?.subscriptionType.name != "Gold"
                        ),
                      ],
                      onDestinationSelected: (value) {
                        switch (value) {
                          case 0: {
                            context.read<NavigationBloc>().add(NavigateToUserHomeProfileInfo());
                          }
                          case 1: {
                            context.read<SubscriptionsBloc>().add(LoadSubscriptionTypesRequest());
                            context.read<NavigationBloc>().add(NavigateToUserHomeSubscription());
                          }
                          case 2: {
                            context.read<NavigationBloc>().add(NavigateToUserHomeRecipes());
                            context.read<FeedRecipesBloc>()
                              .add(LoadRecipesMadeByUserRequest(
                                  username: context.read<UserBloc>().state.user!.username
                                )
                              );
                            context.read<FeedRecipesBloc>()
                              .add(LoadRecipesSavedByUserRequest(
                                  username: context.read<UserBloc>().state.user!.username
                                )
                              );
                          }
                          case 3: {
                            context.read<NavigationBloc>().add(NavigateToUserHomeVideoClasses());
                            context.read<UserVideoClassesBloc>().add(LoadVideoClassesFeed());
                            context.read<UserVideoClassesBloc>().add(
                              LoadVideoClassesStarted(
                                userId: state.user!.username
                              )
                            );
                          }
                          case 4: {
                            context.read<NavigationBloc>().add(NavigateToUserHomeCourses());
                            context.read<UserCoursesBloc>().add(LoadCoursesFeed());
                            context.read<UserCoursesBloc>().add(
                              LoadCoursesEnrolled(
                                userId: state.user!.username
                              )
                            );
                          }
                          case 5: {
                            context.read<NavigationBloc>().add(NavigateToUserHomePromoCodes());
                            context.read<UserPromosBloc>().add(LoadPromosForUserRequest());
                            context.read<UserPromosBloc>().add(
                              LoadPromosActivatedByUser(
                                userId: state.user!.username
                              )
                            );
                          }
                          default: {
                            context.read<NavigationBloc>().add(NavigateToUserHomeProfileInfo());
                          }
                        }
                      },
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 1,
                  ),
                  Expanded(
                    child: switch (navigationRailIndex) {
                      0 => const UserProfilePage(),
                      1 => const UserSubscriptionPage(),
                      2 => const RecipesFeedPage(),
                      3 => const UserVideoClassesFeedPage(),
                      4 => const UserCoursesFeedPage(),
                      5 => const UserPromosFeedPage(),
                      _ => const UserProfilePage()
                    }
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
