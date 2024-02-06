// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String password;

  UserModel({
    required this.uid, 
    required this.email,
    required this.name,
    required this.password
    });

  Map toMap(UserModel user){
    // ignore: unused_local_variable
    var data=<String, dynamic>{};
    data['uid']=user.uid;
    data['email']=user.email;
    data['name']=user.name;
    data['password']=user.password;
    return data;
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> mapData){
    return UserModel(
      uid : mapData['uid'], 
      email: mapData['email'], 
      name: mapData['name'], 
      password: mapData['password']);
  }
}
