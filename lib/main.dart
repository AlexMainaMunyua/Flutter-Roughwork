import 'package:flutter/material.dart';
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
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '''How are you'''.replaceAll("\n", " ").replaceAll("  ", "");
  String search;
  TextStyle posRes =
          TextStyle(color: Colors.black, backgroundColor: Colors.red),
      negRes = TextStyle(color: Colors.black, backgroundColor: Colors.white);

  List<Match> matches = <Match>[];

  AutoScrollController controller;

  TextSpan searchMatch(String match) {
    if (search == null || search == "")
      return TextSpan(text: match, style: negRes);

    // content
    var refinedMatch = match.toLowerCase();

    // searched text
    var refinedSearch = search.toLowerCase();

    for (String token in refinedSearch.split(" ")) {
      if (token.contains(refinedSearch)) {
        matches.addAll(token.allMatches(refinedMatch));
        print(matches.length);
      }
    }

    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: posRes,
          text: match.substring(
              0, refinedSearch.length), // a sub string of the searched text
          children: [
            searchMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: posRes);
      } else {
        return TextSpan(
          style: negRes,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negRes);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negRes,
      children: [
        searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
      ],
    );
  }

  List<int> _index = List();

  Future incrementIndex(int i) async {
    _index[i]++;

    await controller.scrollToIndex(_index[i],
        preferPosition: AutoScrollPosition.middle);
  }

  Future decrementIndex(int i) async {
    if (_index[i] <= 0) {
      _index[0] = 0;
    } else {
      _index[i]--;
    }
    await controller.scrollToIndex(_index[i],
        preferPosition: AutoScrollPosition.middle);
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    );
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
                        // onPressed: () =>
                        // incrementIndex(),
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
                      // onPressed: () => decrementIndex(matches.indexOf(search)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // body: Scrollbar(
        //   child: SingleChildScrollView(
        //     child: RichText(
        //       textScaleFactor: 1.5,
        //       text: searchMatch(
        //         text,
        //       ),
        //     ),
        //   ),
        // ),
        body: ListView.builder(
          controller: controller,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: RichText(
                  textScaleFactor: 1.2,
                  text: searchMatch(text),
                ),
              ),
            );
          },
        ));
  }
}
