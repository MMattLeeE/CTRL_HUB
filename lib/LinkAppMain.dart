import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

import 'package:cloud_functions/cloud_functions.dart';

class LinkAppMain extends StatefulWidget {
  const LinkAppMain({Key? key}) : super(key: key);

  @override
  _LinkAppMainState createState() => _LinkAppMainState();
}

class _LinkAppMainState extends State<LinkAppMain> {
  late PlaidLink _plaidLinkToken;
  String _linkToken = 'Getting Link Token...';
  bool _linkReady = false;

  // explaination for how futures/promises work :
  // https://dart.dev/codelabs/async-await
  @override
  void initState() {
    super.initState();

    _getLinkToken('MMattLeeE');
  }

  void _getLinkToken(String userId) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getLinkToken');
    final message = await callable({'userId': userId});

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

    print(_linkToken.runtimeType);
    print(_linkToken);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$_linkToken'),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _linkReady ? () => _plaidLinkToken.open() : null,
                child: Text("Open Plaid Link (Link Token)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
