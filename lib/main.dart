import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_to_do_app/screens/home_page.dart';
import 'package:firebase_to_do_app/screens/login_screen.dart';
// import 'package:firebase_to_do_app/screens/rafay.dart';
import 'package:firebase_to_do_app/screens/sign_up_page.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase TO-DO',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,

      routes: {
        "/": (context) => const Home(),
        Home.id: (context) => const Home(),
        // "rafay" :(context) => const UserInformation(),
        LoginPage.id: (context) => const LoginPage(),
        SignUpPage.id: (context) => const SignUpPage(),
      },
      // home: UserInformation(),
    );
  }
}
