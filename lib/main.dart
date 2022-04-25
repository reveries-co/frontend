import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/screens/add_fleeting_note.dart';
import 'package:reveries_app/screens/demo.dart';
import 'package:reveries_app/screens/login.dart';
import 'package:reveries_app/screens/logout.dart';

import 'blocs/auth_block.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "reveries",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<AuthBloc>(create: (_) => AuthBloc())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        DemoScreen.routeName: (context) => DemoScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        AddFleetingNoteScreen.routeName: (context) => AddFleetingNoteScreen(),
        LogoutScreen.routeName: (context) => LogoutScreen(),
      },
    );
  }
}

