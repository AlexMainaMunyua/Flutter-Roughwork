import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing_application/src/search_and_highlight.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scroll To Index Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // search and Highlights
      home: HighLight()

      // contact Service
      // home: ContactsExampleApp(),

      // creamy field
      // home: MyEditorApp()

      // home: MyhomePage(),

      // home: WelcomeToGroup(),

      // home: ChangeFontStyle(),
    );
  }
}

class HighLight extends StatefulWidget {
  const HighLight({Key key}) : super(key: key);

  @override
  _HighLightState createState() => _HighLightState();
}

class _HighLightState extends State<HighLight> {

  AutoScrollController autoController;

  List<String> list = ['Good morning friends', 'How are you doing today', 'morning is the best time to exercise', 'I dont know why he doesnt morning want us to use one branch', 'I am sure he is willing to help', 'I think he is just playing game', 'All eyes on me now', 'Ill try my best to be morning the best'];

  String match = '';

  List<int> itemList = [];

  int counter = -1;

  @override
  void initState() {
    super.initState();
    autoController = new AutoScrollController();

    autoController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () =>  _prevCounter(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextCounter,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        controller: autoController,
          itemCount: list.length,
          itemBuilder: (context, index){


            for(var item in list){
              if(item.contains(match)) {
                itemList.add(list.indexOf(item));
              }}

            return AutoScrollTag(
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




   _nextCounter(){
     if(itemList.isNotEmpty ){
       setState(() {
         counter++;
       });
       return _scrollToCounter();
     }
  }

   _prevCounter(){
    if(itemList.isNotEmpty){
      setState(() {
        counter--;
      });
      return _scrollToCounter();

    }
  }

  Future _scrollToCounter() async{
    print(itemList);
    print(counter);

    var index = itemList.elementAt(counter);

    print("index $index");

    await autoController.scrollToIndex(index, preferPosition: AutoScrollPosition.middle);

    autoController.highlight(index);

  }
}


