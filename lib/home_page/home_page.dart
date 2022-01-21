import 'package:flutter/material.dart';
import 'package:flutter_ctrl/common_widgets/social_icon_button.dart';
import 'package:flutter_ctrl/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _logOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
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
          onPressed: () => _logOut(context),
        ),
      ),
    );
  }
}
