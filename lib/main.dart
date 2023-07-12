// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mess_app/Screens/settings.dart';
import 'package:mess_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'Screens/authScreen.dart';
import 'Screens/home.dart';
import 'firebase_options.dart';
import 'package:mess_app/Screens/landing.dart';

import 'services/userCustom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserCustom>(
      // Добавьте ChangeNotifierProvider
      create: (_) => UserCustom(),
      child: MaterialApp(
        title: 'MessApp',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(50, 65, 85, 1),
          textTheme: TextTheme(titleMedium: TextStyle(color: Colors.white)),
        ),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? HomePage()
            : AuthenticationPage(),
        routes: {
          '/home': (context) => HomePage(),
          '/auth': (context) => AuthenticationPage(),
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
