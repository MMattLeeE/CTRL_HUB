import 'dart:convert';
import 'assets/config.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plaid_flutter/plaid_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PlaidLink _plaidLinkToken;
  var newpublicToken;
  var CLIENT_ID = plaid_keys['client_id'];
  var SECRET = plaid_keys['sandbox_secret'];
  var unique_per_user = "user_good";

  @override
  void initState() {
    super.initState();
    getLinkToken();
  }

  getLinkToken() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var data =
        '{ "client_id": "$CLIENT_ID", "secret": "$SECRET", "user": { "client_user_id": "$unique_per_user" }, "client_name": "Plaid App", "products": ["auth"], "country_codes": ["US"], "language": "en", "webhook": "https://sample-web-hook.com", "account_filters": { "depository": { "account_subtypes": ["checking"] } } }';

    var res = await http.post(
        Uri.parse('https://sandbox.plaid.com/link/token/create'),
        headers: headers,
        body: data);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);

    Map<String, dynamic> responseJson = json.decode(res.body);
    var response_link_token = responseJson['link_token'];
    print(response_link_token);

    LinkConfiguration configuration = LinkTokenConfiguration(
      token: response_link_token,
    );

    _plaidLinkToken = PlaidLink(
      configuration: configuration,
      onSuccess: _onSuccessCallback,
      onExit: _onExitCallback,
      onEvent: _onEventCallback,
    );
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    newpublicToken = publicToken;
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError error, LinkExitMetadata metadata) {
    print("onExit: $error, metadata: ${metadata.description()}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.lightBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
