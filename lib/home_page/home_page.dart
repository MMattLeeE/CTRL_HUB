import 'package:flutter/material.dart';
import 'package:flutter_ctrl/common_widgets/social_icon_button.dart';

import '../services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  Future<void> _logOut() async {
    try {
      await auth.logOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Container(
        child: SocialIconButton(
          alignment: Alignment.center,
          text: 'Logout',
          onPressed: _logOut,
        ),
      ),
    );
  }
}
