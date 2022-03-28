import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';
import 'package:reveries_app/widgets/reveries_bottom_tabs.dart';

import '../blocs/auth_block.dart';
import 'login.dart';

class AddFleetingNoteScreen extends StatefulWidget {
  const AddFleetingNoteScreen({Key? key}) : super(key: key);
  static const routeName = '/fleeting/add';

  @override
  State<AddFleetingNoteScreen> createState() => _AddFleetingNoteScreenState();
}

class _AddFleetingNoteScreenState extends State<AddFleetingNoteScreen> {
  late StreamSubscription<User?> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((gUser) {
      if (gUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return StreamBuilder<User?>(
      stream: authBloc.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final User user = snapshot.data as User;

        return Scaffold(
            backgroundColor: Color(0xFFf3f2fa),
            appBar: ReveriesAppBar.getReveriesAppBar(context, user),
            body: Center(),
            bottomNavigationBar: ReveriesBottomTabs()
        );
      }
    );
  }
}
