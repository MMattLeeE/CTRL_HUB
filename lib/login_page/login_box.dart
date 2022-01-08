import 'package:flutter/material.dart';

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
        child: Align(
          //adjust location of the box
          alignment: Alignment(0, -.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(52, 12, 20, 24),
                child: Text(
                  'CTRL_hub',
                  style: Theme.of(context).textTheme.headline2?.merge(
                        TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(52, 12, 30, 24),
                child: Text(
                  'Central front end for projects and utilites',
                  style: Theme.of(context).textTheme.headline4?.merge(
                        TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(52, 12, 20, 24),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Sign in with Google'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
