// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/Screens/settings.dart';
import 'package:mess_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'authScreen.dart';

class HomePage extends StatelessWidget {
  User? user;
  String? email;
  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? 'Гость';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 43, 43),
      appBar: AppBar(
        title: Text(
          'MessApp',
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration:
                      Duration(milliseconds: 1000), // Длительность анимации
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AuthenticationPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = Offset(-1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text(email!),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 29, 29),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.group_outlined,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Создать группу',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.person_outline_rounded,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Контакты',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.phone_outlined,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Звонки',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.bookmark_outline_rounded,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Избранное',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),

            // Добавление элемента с шестеренкой и надписью
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Настройки',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) =>
                        SettingsScreen(),
                  ),
                );
              },
            ),

            Divider(
              thickness: 2,
            ),

            ListTile(
              leading: Icon(
                Icons.person_add_outlined,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Пригласить друзей',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
              title: Text(
                'Возможности MessApp',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Home',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
