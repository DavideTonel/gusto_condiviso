import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/admin/admin_bloc.dart';
import 'package:gusto_condiviso/bloc/company/company_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/course/course_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/course_creation/course_creation_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/teacher/teacher_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/courses/user/user_courses_bloc.dart';
import 'package:gusto_condiviso/bloc/login/admin/admin_login_bloc.dart';
import 'package:gusto_condiviso/bloc/login/company/company_login_bloc.dart';
import 'package:gusto_condiviso/bloc/login/teacher/teacher_login_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/company/company_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/promo/promo_bloc.dart';
import 'package:gusto_condiviso/bloc/promos/user/user_promos_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/categories/recipe_categories_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/ingredients/ingredients_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe/recipe_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/feed_recipes/feed_recipes_bloc.dart';
import 'package:gusto_condiviso/bloc/login/user/user_login_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipe_creation/recipe_creation_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/recipes_search/recipes_search_bloc.dart';
import 'package:gusto_condiviso/bloc/recipes/tools/tools_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/company/company_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/teacher/teacher_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/user/user_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/subscription/subscription_bloc.dart';
import 'package:gusto_condiviso/bloc/teacher/teacher_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/user/user_video_classes_bloc.dart';
import 'package:gusto_condiviso/bloc/video_classes/video_class/video_class_bloc.dart';
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
        BlocProvider(
          create: (context) => UserVideoClassesBloc()
        ),
        BlocProvider(
          create: (context) => UserCoursesBloc()
        ),
        BlocProvider(
          create: (context) => UserPromosBloc()
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
        BlocProvider(
          create: (context) => VideoClassBloc()
        ),
        BlocProvider(
          create: (context) => TeacherCoursesBloc()
        ),
        BlocProvider(
          create: (context) => CourseCreationBloc()
        ),
        BlocProvider(
          create: (context) => CourseBloc()
        ),
        // Company
        BlocProvider(
          create: (context) => CompanyLoginBloc()
        ),
        BlocProvider(
          create: (context) => CompanySigninBloc()
        ),
        BlocProvider(
          create: (context) => CompanyBloc()
        ),
        BlocProvider(
          create: (context) => CompanyPromosBloc()
        ),
        BlocProvider(
          create: (context) => PromoBloc()
        ),
        BlocProvider(
          create: (context) => TeacherCoursesBloc()
        ),
        // Admin
        BlocProvider(
          create: (context) => AdminLoginBloc()
        ),
        BlocProvider(
          create: (context) => AdminBloc()
        ),
        BlocProvider(
          create: (context) => RecipeCategoriesBloc()
        ),
        BlocProvider(
          create: (context) => IngredientsBloc()
        ),
        BlocProvider(
          create: (context) => ToolsBloc()
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
