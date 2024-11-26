import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/login/teacher/teacher_login_bloc.dart';
import 'package:gusto_condiviso/bloc/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/login/user/user_login_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipe_creation/recipe_creation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/teacher/teacher_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/user/user_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/subscription/subscription_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/teacher/teacher_video_classes_bloc.dart';
import 'package:gusto_condiviso/navigation/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final appRouter = AppRouter(context);
    
    return MultiBlocProvider(
      providers: [
        // User
        BlocProvider(
          create: (context) => UserLoginBloc()
        ),
        BlocProvider(
          create: (context) => UserSigninBloc()
        ),
        BlocProvider(
          create: (context) => NavigationBloc()
        ),
        BlocProvider(
          create: (context) => UserBloc()
        ),
        BlocProvider(
          create: (context) => SubscriptionsBloc()
        ),
        BlocProvider(
          create: (context) => RecipeCreationBloc()
        ),
        BlocProvider(
          create: (context) => FeedRecipesBloc()
        ),
        BlocProvider(
          create: (context) => RecipeBloc()
        ),
        BlocProvider(
          create: (context) => RecipesSearchBloc()
        ),
        // Teacher
        BlocProvider(
          create: (context) => TeacherLoginBloc()
        ),
        BlocProvider(
          create: (context) => TeacherSigninBloc()
        ),
        BlocProvider(
          create: (context) => TeacherBloc()
        ),
        BlocProvider(
          create: (context) => TeacherVideoClassesBloc()
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const UserHomePage(),
        //home: const UserLoginPage(),
      ),
    );
  }
}
