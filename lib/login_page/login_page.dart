import 'package:flutter/material.dart';
import 'package:flutter_ctrl/login_page/login_box.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      //the center CTRL_hub UI element
      child: Center(
        child: LoginBox(),
      ),
    );
  }
}
