import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCustom extends ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  late final Map<String, dynamic> userData;
  String? phoneNumber;
  String? userName;
  String? description;

  User? get user => _user;

  UserCustom() {
    loadUserData();
  }
  Future<void> loadUserData() async {
    try {
      final firestore = FirebaseFirestore.instance;

      final userDoc = await firestore.collection('Users').doc(_user?.uid).get();

      if (userDoc.exists) {
        userData = userDoc.data() as Map<String, dynamic>;

        phoneNumber = userData['PhoneNumber'];
        userName = userData['UserName'];
        description = userData['Description'];

        notifyListeners(); // Уведомляем слушателей об изменении данных
      }
    } catch (error) {
      print('Ошибка при загрузке данных пользователя: $error');
    }
  }

  Future<void> saveUserData() async {
    try {
      final firestore = FirebaseFirestore.instance;

      final userDoc = firestore.collection('Users').doc(_user?.uid);

      await userDoc.set({
        'PhoneNumber': phoneNumber,
        'UserName': userName,
        'Description': description,
      });

      // Выполняем необходимые действия после сохранения данных

      notifyListeners(); // Уведомляем слушателей об изменении данных
    } catch (error) {
      print('Ошибка при сохранении данных пользователя: $error');
    }
  }
}
