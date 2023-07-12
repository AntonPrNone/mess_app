// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_app/services/auth.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user;
  String? name;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    nameController.text = user?.displayName ?? '';
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          phoneNumberController.text = snapshot.data()!['PhoneNumber'] ?? '';
          usernameController.text = snapshot.data()!['UserName'] ?? '';
          aboutController.text = snapshot.data()!['Description'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    name = user?.displayName ?? 'Гость';
    return Scaffold(
      body: GestureDetector(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                leading: Icon(
                  Icons.account_circle,
                  size: 75,
                ),
                title: Text(
                  name!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Статус сети',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Аккаунт',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneNumberController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android),
                labelText: 'Номер телефона',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                labelText: 'Имя',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: usernameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Имя пользователя',
                prefixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Text(
                    '@',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: aboutController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_sharp),
                labelText: 'О себе',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 1,
            ),
            SizedBox(height: 32),
            IconButton(
              onPressed: () {
                saveChanges();
              },
              icon: Icon(
                Icons.save,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveChanges() {
    User? currentUser = user;
    if (currentUser != null) {
      String phoneNumber = phoneNumberController.text;
      String name = nameController.text;
      String username = usernameController.text;
      String about = aboutController.text;

      // Обновляем данные пользователя в Firestore
      FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).set({
        'PhoneNumber': phoneNumber,
        'UserName': username,
        'Description': about,
      }, SetOptions(merge: true)).then((_) {
        // Обновляем имя пользователя в Firebase Authentication
        currentUser.updateDisplayName(name).then((_) {
          // Данные пользователя успешно обновлены в Firestore и Firebase Authentication
          showSnackBar('Изменения сохранены');
        }).catchError((error) {
          // Обработка ошибки при обновлении имени пользователя в Firebase Authentication
          showSnackBar('Ошибка при сохранении имени пользователя: $error');
        });
      }).catchError((error) {
        // Обработка ошибки при обновлении данных пользователя в Firestore
        showSnackBar('Ошибка при сохранении изменений: $error');
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
