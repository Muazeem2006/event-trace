import 'package:event_trace/models/User.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  final List<User> _userList = [];

  List<User> get userList => _userList;

  UserNotifier() {
    // Initialization logic can be added here.
  }

  // adding user
  addUser(User user) {
    _userList.add(user);
    notifyListeners();
  }

  // removing user
  removeUser(User user) {
    _userList.remove(user);
    notifyListeners();
  }

  // updating user
  void updateUser(User updatedUser) {
    final index = _userList.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _userList[index] = updatedUser;
      notifyListeners();
    }
  }

  // loading users from server into the provider
  UserNotifier.all(List<User> users) {
    _userList.addAll(users);
    notifyListeners();
  }
}

