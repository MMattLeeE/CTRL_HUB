import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
//below code uneeded for a web app; with multiple platforms would need to use:
//import 'package:google_sign_in/google_sign_in.dart';
//import 'dart:convert';

class AuthException implements Exception {
  String errMsg() => 'ERROR: Require a logged in User. Please log in first.';
}

class LinkAppMain extends StatefulWidget {
  const LinkAppMain({Key? key}) : super(key: key);

  @override
  _LinkAppMainState createState() => _LinkAppMainState();
}

class _LinkAppMainState extends State<LinkAppMain> {
  late PlaidLink _plaidLinkToken;
  String _linkToken = 'No link token found';
  String _accessToken = '';
  String _itemId = '';
  //String _userName = 'MMattLeeE';
  User? _currentUser;
  UserCredential? _userCred;

  List<dynamic> _transactionData = [
    {
      'date': '1/2/3',
      'merchant_name': 'default',
      'amount': 200,
    }
  ];
  bool _linkReady = false;
  bool _auth = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          _currentUser = user;
        });
      } else {
        print('User is signed in!');
        setState(() {
          _currentUser = user;
        });
      }
    });
  }

  void signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    UserCredential userCred =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    setState(() {
      _userCred = userCred;
    });
    print(_userCred?.credential);
    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _getLinkToken() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getLinkToken');

    try {
      if (_currentUser == null) {
        throw new AuthException();
      }
      final message = await callable();

      // after getting link token, build the Plaid Link object to be called later
      setState(() {
        _linkToken = message.data['link_token'];

        LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
          token: _linkToken,
        );

        _plaidLinkToken = PlaidLink(
          configuration: linkTokenConfiguration,
          onSuccess: _onSuccessCallback,
          onEvent: _onEventCallback,
          onExit: _onExitCallback,
        );

        _linkReady = true;
      });
    } on AuthException catch (e) {
      print(e.errMsg());
    } catch (e) {
      print(e);
    }
    //print(_linkToken.runtimeType);
    print(_linkToken);
  }

  void _exchangePublicToken(String publicToken) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('exchangePublicToken');
    final message = await callable({'publicToken': publicToken});
    setState(() {
      _accessToken = message.data['access_token'];
      _itemId = message.data['item_id'];
      _auth = true;
    });
    print(_accessToken);
    print(_itemId);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    //call cloud function to exchange public Token
    _exchangePublicToken(publicToken);
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  void _getTransactions(String _accessToken) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getTransactions');
    final message = await callable({'accessToken': _accessToken});
    setState(() {
      _transactionData = message.data;
    });
    /*
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    for (var transaction in _transactionData) {
      String prettyprint = encoder.convert(transaction);
      print(prettyprint);
    }
    */
    print('TOTAL NUMBER TRANSACTIONS: ' + _transactionData.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //GOOGLE LOGIN BUTTON
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => signInWithGoogle(),
              child: Text('Sign In Google'),
            ),
            ElevatedButton(
              onPressed: () => signOut(),
              child: Text('sign Out'),
            ),
            Text('${_currentUser?.email}'),
            Text('${_currentUser?.displayName}'),

            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _getLinkToken(),
              child: Text('Get Token'),
            ),
            Text('$_linkToken'),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _linkReady ? () => _plaidLinkToken.open() : null,
              child: Text("Authenticate"),
            ),
            Text('$_accessToken'),
            Text('$_itemId'),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _auth ? () => _getTransactions(_accessToken) : null,
              child: Text("get Transactions"),
            ),
            SizedBox(height: 15),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Merchant Name')),
                    DataColumn(label: Text('Amount')),
                  ],
                  rows: List<DataRow>.generate(
                    _transactionData.length,
                    (int index) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('${_transactionData[index]["date"]}'),
                        ),
                        DataCell(
                          Text('${_transactionData[index]["merchant_name"]}'),
                        ),
                        DataCell(
                          Text('${_transactionData[index]["amount"]}'),
                        ),
                      ],
                    ),
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
