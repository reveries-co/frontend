import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';

import '../blocs/auth_block.dart';
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
              body: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Permanent Notes',
                        style: TextStyle(
                          fontFamily: 'Source Serif Pro',
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: const Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 16.0,
                                spreadRadius: 5.0,
                              ),
                            ]),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 25.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    ' #14 Liquid Modernity',
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    '1 day ago',
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      height: 0.5,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12.0,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, bottom: 20, right: 20, top: 10),
                                child: Text(
                                  'Very interesting way of describing how people my age see their vision of the world, and how future societies, but you won\'t be an innovator. ',
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    height: 2,
                                    fontSize: 12.0,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF979797),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.account_tree_rounded,
                                    color: Color(0xFFE35D47),
                                    size: 15.0,
                                  ),
                                  Text(
                                    "  12, 3",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.0,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ReveriesBottomTabs());
        });
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }
}
