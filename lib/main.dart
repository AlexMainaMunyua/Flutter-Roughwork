import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing_application/src/creamy_field.dart';
import 'package:flutter_testing_application/src/pay.dart';
import 'package:flutter_testing_application/src/search_and_highlight.dart';
import 'package:google_pay/google_pay.dart';

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
      home: SearchandHighlights()

      // contact Service
      // home: ContactsExampleApp(),

      // creamy field
      // home: MyEditorApp()

      // home: PayMaterialApp(),

      // home: WelcomeToGroup(),

      // home: MergeTextStyle(),
    );
  }
}

class MergeTextStyle extends StatefulWidget {
  const MergeTextStyle({Key key}) : super(key: key);

  @override
  _MergeTextStyleState createState() => _MergeTextStyleState();
}

class _MergeTextStyleState extends State<MergeTextStyle> {
  List<TextSpan> textParts = [
    TextSpan(text: "Hello", style: TextStyle(color: Colors.red)),
    TextSpan(text: " World")
  ];

  String search;

  List<Match> matches = <Match>[];

  TextStyle posRes =
          TextStyle(color: Colors.black, backgroundColor: Colors.red),
      negRes = TextStyle(color: Colors.black, backgroundColor: Colors.white);

  @override
  void initState() {
    super.initState();
  }

  List<TextSpan> searchMatch(List<TextSpan> match) {
    List<TextSpan> _list = [];
    if (search == null || search == "") {
      _list.add(TextSpan(children: match, style: negRes));
      return _list;
    }

    var refinedMatch = match.join().toLowerCase();

    print(refinedMatch);

    var refinedSearch = search.toLowerCase();

    for (String token in refinedSearch.split(" ")) {
      if (token.contains(refinedSearch)) {
        matches.addAll(token.allMatches(refinedMatch));
      }
    }

    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        print("here 1");
        _list.add(TextSpan(
            style: posRes,
            text: refinedMatch.substring(0, refinedSearch.length),
            children: searchMatch(match)));
        return _list;
        // return TextSpan(
        //   style: posRes,
        //   text: match.substring(
        //       0, refinedSearch.length), // a
        //       match.substring(
        //         refinedSearch.length,
        //       ),
        //     ), sub string of the searched text
        //   children: [
        //     searchMatch(
        //       match.substring(
        //         refinedSearch.length,
        //       ),
        //     ),
        //   ],
        // );
      } else if (refinedMatch.length == refinedSearch.length) {
        print("here 2");
        // _list.add(TextSpan(text: match.join(), style: posRes));
        // return _list;
        // return TextSpan(text: match, style: posRes);
      } else {
        int x = refinedMatch.indexOf(refinedSearch);
        print("here 3 $x");
        _list.add(TextSpan(style: negRes, text: match.join()));

        return _list;
        // return TextSpan(
        //   style: negRes,
        //   text: match.substring(
        //     0,
        //     refinedMatch.indexOf(refinedSearch),
        //   ),
        //   children: [
        //     searchMatch(
        //       match.substring(
        //         refinedMatch.indexOf(refinedSearch),
        //       ),
        //     ),
        //   ],
        // );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      print("here 4");
      // _list.add(TextSpan(text: match.join(), style: negRes));
      // return _list;
      // return TextSpan(text: match, style: negRes);
    }
    print("here 5");
    // _list.add(TextSpan(
    //     style: negRes,
    //     text: match.join().substring(0, refinedMatch.indexOf(refinedSearch)),
    //     children: searchMatch(match)));
    // return _list;
    // return TextSpan(
    //   text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
    //   style: negRes,
    //   children: [
    //     searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Search"),
                    onChanged: (t) {
                      setState(() => search = t);
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          // incrementIndex(),
                        },
                        icon: Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // decrementIndex(matches.indexOf(search));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                child: Text.rich(
                  TextSpan(children: searchMatch(textParts)),
                  maxLines: 10,
                ),
              ),
            );
          },
        ));
  }
}
