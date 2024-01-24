// user_model.dart
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String? userName;
  String? userEmail;

  void setUserInformation(String name, String email) {
    userName = name;
    userEmail = email;
    notifyListeners();
  }
}
