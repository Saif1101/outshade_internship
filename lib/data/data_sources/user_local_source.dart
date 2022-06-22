import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:outshade_internship/data/models/user_model.dart';
import 'package:outshade_internship/domain/entities/registered_user_entity.dart';

abstract class UserDataSource{
  Future<List<RegisteredUserEntity>> getRegisteredUsers(); 
  Future<List<UserModel>> getUsers(); 
  Future<void> registerUser(RegisteredUserEntity user); 
  
  
}

class UserDataSouceImpl extends UserDataSource{
  @override
  Future<List<RegisteredUserEntity>> getRegisteredUsers() async {
    bool exists = await Hive.boxExists('usersBox');

    print('Box Exists?: $exists');
    if (exists) {
      final usersDB = await Hive.openBox('usersBox'); 
      var userList = usersDB.keys;
      print('Keys $userList');
      List<RegisteredUserEntity> registeredUsers = [];
      userList.forEach((element) { 
        print('Fetching elements : $element');
        registeredUsers.add(usersDB.getAt(element) as RegisteredUserEntity);
      });
      print(registeredUsers);
      return registeredUsers;
    } else {
      final usersDB = await Hive.openBox<RegisteredUserEntity>('usersBox');
      var userList = usersDB.values.toList();
      return userList;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final jsondata = await rootBundle.loadString('assets/data.json');

    final response = json.decode(jsondata);

    List<UserModel> users =[]; 
      response['users'].forEach((v) async {
        users.add(UserModel.fromJson(v));
      });
    
    return users; 
  }

  @override
  Future<void> registerUser(RegisteredUserEntity user) async {
    print('Inside local source');
    var usersDB = Hive.box('usersBox');
    await usersDB.add(user);
  }

}