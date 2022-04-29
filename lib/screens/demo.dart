import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';

import '../blocs/auth_block.dart';
import '../widgets/note_card.dart';
import '../widgets/reveries_bottom_tabs.dart';
import 'login.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
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
    super.initState();
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
              body: Column(
                children: [
                  Text(
                    'Permanent Notes',
                    style: TextStyle(
                      fontFamily: 'Source Serif Pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 40.0,
                    ),
                  ),
                  NoteCard(
                    title: "#14 Liquity Modernity",
                    body: 'Very interesting way of describing how people my age see their vision of the world, and how future societies, but you won\'t be an innovator. ',
                  )
                ],
              ),
              bottomNavigationBar: ReveriesBottomTabs());
        }
    );
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }
}
