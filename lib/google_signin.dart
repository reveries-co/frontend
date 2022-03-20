import 'dart:async';
import 'dart:convert' show json;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/services/auth_service.dart';
import 'models/user.dart' as models;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class GoogleSignInDemo extends StatefulWidget {
  @override
  State createState() => GoogleSignInDemoState();
}

class GoogleSignInDemoState extends State<GoogleSignInDemo> {
  models.User? _currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    this._currentUser = authService.user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(context),
        ));
  }

  Widget _buildBody(BuildContext context) {
    final models.User? user = _currentUser;
    var email = "";
    if (user != null) {
      email = user.email;
    }
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Signed in successfully. ${email}'),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn(context),
          ),
        ],
      );
    }
  }

  VoidCallback _handleSignIn(context) {
    return () async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final authService = Provider.of<AuthService>(context, listen: false);
          authService.authenticateWithGoogle(googleUser);
        }
      } catch (error) {
        print(error);
      }
    };
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}
