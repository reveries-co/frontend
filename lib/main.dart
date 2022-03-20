import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/demo_screen.dart';
import 'package:reveries_app/google_signin.dart';
import 'package:reveries_app/services/auth_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(create: (_) => AuthService())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DemoScreen(),
        '/login': (context) => GoogleSignInDemo()
      },
      debugShowCheckedModeBanner: true,
    );
  }
}

