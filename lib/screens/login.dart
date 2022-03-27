import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.user != null) {
      // user already authenticated let's redirect to main screen
      Navigator.of(context).pushNamed("/");
    }
    return Text("Login");
  }
}
