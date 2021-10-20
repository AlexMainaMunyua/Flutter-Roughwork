import 'package:flutter/material.dart';
import 'package:flutter_testing_application/src/contact_service.dart';
import 'package:flutter_testing_application/src/creamy_field.dart';
import 'package:flutter_testing_application/src/search_and_highlight.dart';
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
        // home: SearchandHighlights()

        // contact Service
        home: ContactsExampleApp(),

        // creamy field
        // home: MyEditorApp()

        );
  }
}
