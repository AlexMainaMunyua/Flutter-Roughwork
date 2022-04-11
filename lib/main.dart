import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:flutter_testing_application/src/in_app_billing.dart';
import 'package:flutter_testing_application/src/in_app_purchases.dart';
import 'package:flutter_testing_application/src/pay.dart';
import 'package:flutter_testing_application/src/stackoverflow/button.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scroll To Index Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // search and Highlights
      // home: HighLight()

      // contact Service
      // home: ContactsExampleApp(),

      // creamy field
      // home: MyEditorApp()

      // home: MyhomePage(),

      // home: WelcomeToGroup(),

      // home: ChangeFontStyle(),
      // home: MyHomePage(title:  ' Google ReCaptcha Demo',)
      home: MyAppBilling(),
    );
  }
}

class CircleAva extends StatelessWidget {
  const CircleAva({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
