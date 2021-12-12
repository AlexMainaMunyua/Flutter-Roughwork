import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      // home: ContactsExampleApp(),

      // creamy field
      // home: MyEditorApp()

      // home: MyhomePage(),

      // home: WelcomeToGroup(),

      home: ChangeFontStyle(),
    );
  }
}

class MyhomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyhomePage> {
  static const platform =
      const MethodChannel('flutter_testing_application/launch_contact');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Simple"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Launch contact activity"),
          onPressed: () async => launchContact(),
        ),
      ),
    );
  }

  launchContact() async {
    try {
      await platform.invokeMethod('launch');
    } on PlatformException catch (e) {
      print("Failed to launch contact: ${e.message}");
    }
  }
}

class ChangeFontStyle extends StatelessWidget {


  TextSpan rich(String input) {
    final styles = {
      '_': const TextStyle(fontStyle: FontStyle.italic),
      '*': const TextStyle(fontWeight: FontWeight.bold),
      '~': const TextStyle(decoration: TextDecoration.lineThrough),
    };
    final spans = <TextSpan>[];
    input.trim().splitMapJoin(RegExp(r'([_*~])(.*)?\1'), onMatch: (m) {
      spans.add(TextSpan(text: m.group(2), style: styles[m.group(1)]));
      return '';
    }, onNonMatch: (String text) {
      spans.add(TextSpan(text: text));
      return '';
    });
    return TextSpan(style: const TextStyle(fontSize: 24), children: spans);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Text"),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("Hello"),
            RichText(text: rich('_Hello_')),
            Text("Hello")
          ],
        ),
      ),
    );
  }
}
