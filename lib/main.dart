import 'package:flutter/material.dart';
import 'package:gusto_condiviso/pages/entry_point/entry_point_page.dart';
import 'package:gusto_condiviso/pages/entry_point/login/user_login_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/company_signin_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/teacher_signin_page.dart';
import 'package:gusto_condiviso/pages/entry_point/signin/user_signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EntryPointPage(),
    );
  }
}
