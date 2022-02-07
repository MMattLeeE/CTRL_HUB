import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ctrl/common_widgets/alert_dialog_exception.dart';

import 'package:flutter_ctrl/services/auth.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_text.dart';
import '../common_widgets/social_icon_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    alertDialogException(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymous(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.logInAnonymous();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
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
              SizedBox(
                height: 50,
                child: _buildHeader(),
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
                onPressed: _isLoading ? null : () => _signInWithGoogle(context),
              ),
              SocialIconButton(
                text: 'Sign in Anonymously',
                alignment: Alignment.centerRight,
                fillColor: Colors.blue.shade100,
                textColor: Colors.black,
                padding: EdgeInsets.only(right: 40),
                onPressed: _isLoading ? null : () => _signInAnonymous(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  // building out the header and widget to show a progress indicator
  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomText(
      text: "CTRL_hub",
      padding: EdgeInsets.fromLTRB(52, 0, 10, 10),
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
