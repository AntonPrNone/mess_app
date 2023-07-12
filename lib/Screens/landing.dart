// ignore_for_file: prefer_const_declarations, dead_code, prefer_const_constructors, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authScreen.dart';
import 'home.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = context.watch<FirebaseAuth>();
    final bool isLoggedIn = auth.currentUser != null;
    return isLoggedIn ? HomePage() : AuthenticationPage();
  }
}
