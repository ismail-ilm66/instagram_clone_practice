import 'package:flutter/foundation.dart';
import 'package:instagram_clone_practice/firebase/authentication.dart';
import 'package:instagram_clone_practice/models/user.dart' as model;

class UserProvider extends ChangeNotifier {
  model.User? _user;

  model.User get getUser => _user!;

  Future<void> refreshUser() async {
    _user = await AuthorizationMethods().updateUser();
    notifyListeners();
  }
}
