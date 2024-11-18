import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/login/user_login_bloc.dart';
import 'package:gusto_condiviso/bloc/navigation/navigation_bloc.dart';
import 'package:gusto_condiviso/bloc/signin/user_signin_bloc.dart';
import 'package:gusto_condiviso/bloc/subscription/subscription_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';
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
        )
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
