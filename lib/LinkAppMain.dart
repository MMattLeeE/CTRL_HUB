import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:convert';

class LinkAppMain extends StatefulWidget {
  const LinkAppMain({Key? key}) : super(key: key);

  @override
  _LinkAppMainState createState() => _LinkAppMainState();
}

class _LinkAppMainState extends State<LinkAppMain> {
  late PlaidLink _plaidLinkToken;
  String _linkToken = 'Getting Link Token...';
  String _accessToken = '';
  String _itemId = '';
  String _userName = 'MMattLeeE';
  List<dynamic> _transactionData = [
    {
      'date': '1/2/3',
      'merchant_name': 'default',
      'amount': 200,
    }
  ];
  bool _linkReady = false;
  bool _auth = false;

  // explaination for how futures/promises work :
  // https://dart.dev/codelabs/async-await
  @override
  void initState() {
    super.initState();

    //uncomment if you want to auto call for link token when app load:
    //_getLinkToken('MMattLeeE');
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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => _getLinkToken(_userName),
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
      ),
    );
  }
}
