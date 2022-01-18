import 'package:flutter/material.dart';
import 'package:flutter_ctrl/services/auth.dart';

import '../common_widgets/custom_text.dart';
import '../common_widgets/social_icon_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymous() async {
    try {
      await auth.logInAnonymous();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //the background image and the filter
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/skyscraper.jpg'),
            fit: BoxFit.none,
            alignment: Alignment(-.3, 0),
            scale: 1.0,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.darken,
            ),
          ),
        ),
        //the center Login box
        child: Center(
          child: _loginBox(context),
        ),
      ),
    );
  }

  Widget _loginBox(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.0),
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "CTRL_hub",
                padding: EdgeInsets.fromLTRB(52, 0, 10, 10),
                style: Theme.of(context).textTheme.headline2,
              ),
              CustomText(
                text: ' Central \n front-end \n projects \n utilites',
                padding: EdgeInsets.fromLTRB(52, 5, 30, 14),
                style: Theme.of(context).textTheme.headline5,
              ),
              SocialIconButton(
                text: 'Sign-in with Google',
                alignment: Alignment.centerRight,
                fillColor: Colors.blue.shade100,
                textColor: Colors.black,
                padding: EdgeInsets.only(right: 40),
                image: Image.asset('assets/images/google-logo.png'),
                onPressed: _signInWithGoogle,
              ),
              SocialIconButton(
                text: 'Sign in Anonymously',
                alignment: Alignment.centerRight,
                fillColor: Colors.blue.shade100,
                textColor: Colors.black,
                padding: EdgeInsets.only(right: 40),
                onPressed: _signInAnonymous,
              )
            ],
          ),
        ),
      ),
    );
  }
}
