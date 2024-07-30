import 'package:flutter/material.dart';
import 'package:internshala_assignment/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: "",
    email: "",
    password: "",
    id: "",
    type: "",
    address: "",
    token: "",
  );
  User get user {
    return _user;
  }

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
