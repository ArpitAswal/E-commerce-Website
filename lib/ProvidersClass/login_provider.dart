
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _isLogin = true;
  bool _isHidden = true;
  bool _isLoading = false;

  bool get isLogin => _isLogin;
  bool get isHidden => _isHidden;
  bool get isLoading => _isLoading;

  void toggleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
