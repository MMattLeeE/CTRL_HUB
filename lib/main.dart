//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_ctrl/login_page/login_page.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseFunctions.instanceFor(region: 'us-central1')
        .useFunctionsEmulator('localhost', 5001);
    //FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  } catch (e) {
    print('Failed to initialize');
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
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
