import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/pages/entry_point/entry_point_page.dart';
import 'package:gusto_condiviso/pages/entry_point/login/teacher_login_page.dart';
import 'package:gusto_condiviso/pages/entry_point/login/user_login_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/teacher_signin_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/user_signin_page.dart';
import 'package:gusto_condiviso/pages/home/teacher_home_page.dart';
import 'package:gusto_condiviso/pages/home/user_home_page.dart';
import 'package:gusto_condiviso/pages/recipes/creation/recipe_creation_page.dart';
import 'package:gusto_condiviso/pages/recipes/creation/recipe_review_creation_page.dart';
import 'package:gusto_condiviso/pages/recipes/creation/recipe_step_creation_page.dart';
import 'package:gusto_condiviso/pages/recipes/recipe_page.dart';
import 'package:gusto_condiviso/pages/recipes/recipe_reviews_page.dart';
import 'package:gusto_condiviso/pages/recipes/search/recipe_search_page.dart';
import 'package:gusto_condiviso/pages/recipes/search/recipe_search_results_page.dart';
import 'package:gusto_condiviso/pages/video_classes/creation/video_class_creation_page.dart';

class AppRouter {
  static String entryPoint = "/";
  static String userLogin = "/userLogin";
  static String userHome = "/userHome";

  final GoRouter router;

  AppRouter(BuildContext context) : router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const EntryPointPage(),
      ),
      // User
      GoRoute(
        path: "/userSignin",
        builder: (context, state) => const UserSigninPage(),
      ),
      GoRoute(
        path: "/userLogin",
        builder: (context, state) => const UserLoginPage(),
      ),
      GoRoute(
        path: "/userHome",
        builder: (context, state) => const UserHomePage(),
      ),
      GoRoute(
        path: "/recipeCreation",
        builder: (context, state) => const RecipeCreationPage(),
      ),
      GoRoute(
        path: "/recipeCreation/recipeStepCreation",
        builder: (context, state) => const RecipeStepCreationPage(),
      ),
      GoRoute(
        path: "/recipe",
        builder: (context, state) => const RecipePage(),
      ),
      GoRoute(
        path: "/recipe/reviews",
        builder: (context, state) => const RecipeReviewsPage(),
      ),
      GoRoute(
        path: "/recipe/reviews/createReview",
        builder: (context, state) => const RecipeReviewCreationPage(),
      ),
      GoRoute(
        path: "/recipeSearch",
        builder: (context, state) => const RecipeSearchPage(),
      ),
      GoRoute(
        path: "/recipeSearch/results",
        builder: (context, state) => const RecipeSearchResultsPage(),
      ),
      // Teacher
      GoRoute(
        path: "/teacherSignin",
        builder: (context, state) => const TeacherSigninPage(),
      ),
      GoRoute(
        path: "/teacherLogin",
        builder: (context, state) => const TeacherLoginPage(),
      ),
      GoRoute(
        path: "/teacherHome",
        builder: (context, state) => const TeacherHomePage(),
      ),
      GoRoute(
        path: "/videoClassCreation",
        builder: (context, state) => const VideoClassCreationPage(),
      ),
    ]
  );

  void navigateToEntryPoint(BuildContext context) {
    router.go(entryPoint);
  }

  void navigateToUserLogin(BuildContext context) {
    router.go(userLogin);
  }

  void navigateToUserHome(BuildContext context) {
    router.go(userHome);
  }
}