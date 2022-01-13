import 'package:flutter/material.dart';
import 'package:flutter_ctrl/common_widgets/custom_text.dart';
import 'package:flutter_ctrl/common_widgets/social_icon_button.dart';

class LoginBox extends StatelessWidget {
  const LoginBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
