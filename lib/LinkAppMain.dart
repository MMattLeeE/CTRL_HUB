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

  var message = 'cloud function call return here';

  void _addMessage(var text) {
    debugPrint('pressed button');
    /* HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('addMessage');
    final results = await callable({text: 'testMessageLocal'});
    debugPrint(results.toString()); */
    setState(() {
      message = 'changed';
    });
  }

  @override
  void initState() {
    super.initState();

    LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
      token: "GENERATED_LINK_TOKEN",
    );

    _plaidLinkToken = PlaidLink(
      configuration: linkTokenConfiguration,
      onSuccess: _onSuccessCallback,
      onEvent: _onEventCallback,
      onExit: _onExitCallback,
    );
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
              Text('$message'),
              ElevatedButton(
                onPressed: () => _addMessage,
                child: Text("call emulatior addMessage"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => _plaidLinkToken.open(),
                child: Text("Open Plaid Link (Link Token)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
