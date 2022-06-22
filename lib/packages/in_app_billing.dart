import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_in_app_billing/flutter_in_app_billing.dart';

class MyAppBilling extends StatefulWidget {
  @override
  _MyAppBillingState createState() => _MyAppBillingState();
}

class _MyAppBillingState extends State<MyAppBilling> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await FlutterInAppBilling.initBp(
          "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxS0EbQG9LEvv+9Oik03+WdjQ2InH+ykybDGI2hyo13cCI+LC0wAW/00Xh9g6yVzqXZCAjQ9dFVln4UQNT7XoOvUnQM4xSYv2rl62rGUzUlmiYs+e0docAehnuM30WhmqSHlg5eMVv5sr3B6qlYq7wCtZ4p7Eqyn+8rbl2hJ1EcvK1d8gedcum/GS7uF2eLhU4SBGWTFkRNuqUaaUpTO+4ONu9Zv2r8qn94h5fXlg9cyXX3tABkKBCLtAHdtgnHVVWQazLeM960sIVV9928Z4JKWCtXIjfTPa27Y+an+Uq5ilBYF6dgW5kVZk6bfe/eo22r7VC8HHdRJKPrGpHBplZwIDAQAB");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            FlatButton(
                onPressed: () {
                  FlutterInAppBilling.subscribe(
                      "0018ece943ac4991a36b2a67c8a6764f");
                },
                child: Text("Buy"))
          ],
        ),
      ),
    );
  }
}
