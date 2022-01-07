import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.85),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: Alignment(0, -.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(52, 12, 20, 24),
                        child: Text('CTRL_hub',
                            style: Theme.of(context).textTheme.headline2),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(52, 12, 30, 24),
                        child: Text(
                            'Central front end for projects and utilites',
                            style: Theme.of(context).textTheme.headline4),
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
            ),
          ],
        ),
      ),
    );
  }
}
