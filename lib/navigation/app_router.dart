import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_condiviso/pages/entry_point/entry_point_page.dart';
import 'package:gusto_condiviso/pages/entry_point/login/user_login_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/user_signin_page.dart';
import 'package:gusto_condiviso/pages/home/user_home_page.dart';
import 'package:gusto_condiviso/pages/recipes/creation/recipe_creation_page.dart';
import 'package:gusto_condiviso/pages/recipes/creation/recipe_step_creation_page.dart';

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
      )
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