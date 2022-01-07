import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: Container(
                color: Colors.grey.withOpacity(0.25),
                child: Align(
                  alignment: Alignment(0, -.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 20, 24),
                        child: Text('CTRL_hub',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 30, 24),
                        child: Text(
                            'Central front end for projects and utilites',
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 20, 24),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Sign in with Google'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
