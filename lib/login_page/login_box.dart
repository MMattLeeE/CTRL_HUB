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
          //adjust location of the column
          alignment: Alignment(0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(52, 12, 20, 5),
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
                padding: EdgeInsets.fromLTRB(52, 5, 30, 14),
                child: Text(
                  ' Central \n front-end \n projects \n utilites',
                  style: Theme.of(context).textTheme.headline4?.merge(
                        TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(52, 12, 60, 24),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 40,
                    width: 225,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[200],
                        onPrimary: Colors.black,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              height: 40,
                              width: 50,
                              child:
                                  Image.asset('assets/images/google-logo.png')),
                          Text('Sign in with Google'),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
