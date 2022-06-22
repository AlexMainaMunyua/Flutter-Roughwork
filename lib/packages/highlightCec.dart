import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HighLight extends StatefulWidget {
  const HighLight({Key key}) : super(key: key);

  @override
  _HighLightState createState() => _HighLightState();
}

class _HighLightState extends State<HighLight> {
  AutoScrollController autoController;

  List<String> list = [
    'Good morning friends',
    'How are you doing today',
    'morning is the best time to exercise',
    'I dont know why he doesnt morning want us to use one branch',
    'I am sure he is willing to help',
    'I think he is just playing game',
    'All eyes on me now',
    'Ill try my best to be morning the best'
  ];

  String match = '';

  List<int> itemList = [];

  int counter = -1;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoController = AutoScrollController();

    autoController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    );

    controller.addListener(() async {
      match = controller.text.trim();
      if (match.isEmpty) {
        return;
      }
      itemList.clear(); // clear before new selection
      for (int i = 0; i < list.length; i++) {
        if (list[i].contains(match)) {
          itemList.add(i);
        }
      }
      setState(() {});

      print(itemList);

      /// scroll to 1st match item
      await autoController.scrollToIndex(itemList.first,
          preferPosition: AutoScrollPosition.middle);

      // for (final i in itemList) {
      autoController.highlight(itemList.first);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => _prevCounter(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextCounter,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          controller: autoController,
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            return index == list.length
                ? TextField(
              controller: controller,
            )
                : AutoScrollTag(
                key: ValueKey(index),
                controller: autoController,
                index: index,
                highlightColor: Colors.black.withOpacity(0.1),
                child: ListTile(
                  title: Text('${list[index]}'),
                ));
          }),
    );
  }

  _nextCounter() {
    if (itemList.isNotEmpty) {
      setState(() {
        counter++;
      });
      return _scrollToCounter();
    }
  }

  _prevCounter() {
    if (itemList.isNotEmpty) {
      setState(() {
        counter--;
      });
      return _scrollToCounter();
    }
  }

  Future _scrollToCounter() async {
    print(itemList);
    print(counter);

    var index = itemList.elementAt(counter);

    print("index $index");

    await autoController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.middle);

    autoController.highlight(index);
  }
}