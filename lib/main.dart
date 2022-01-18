//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ctrl/landing_page/landing_page.dart';
import '/config/firebase_config.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'services/auth.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'CTRL_hub',
      options: firebaseConfigs,
    );
    FirebaseFunctions.instanceFor(region: 'us-central1')
        .useFunctionsEmulator('localhost', 5001);
    //FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ctrl Center",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headline2: TextStyle(color: Colors.white70),
          headline3: TextStyle(color: Colors.white70),
          headline4: TextStyle(color: Colors.white70),
          headline5: TextStyle(color: Colors.white60),
          bodyText1: TextStyle(color: Colors.white60),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
