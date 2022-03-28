import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_to_do_app/screens/home_page.dart';
import 'package:firebase_to_do_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Firebase TO-DO',
      debugShowCheckedModeBanner: false,

      home: LoginPage(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
