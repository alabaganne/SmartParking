import 'package:flutter/material.dart';

class User extends ChangeNotifier{

  int? id;
  String? cin;
  String? fullName;
  String? phoneNumber;
  String? role;
  User({this.id, this.cin, this.phoneNumber, this.fullName, this.role});

  set setUser(Map<String, dynamic> user){
    id = user['id'];
    cin = user['cin'];
    fullName = user['name'];
    phoneNumber = user['phoneNumber'];
    role = user['role'];
    notifyListeners();
  }
}