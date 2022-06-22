import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Bar"),),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15)),
            onPressed: (){},
            child: const Text('My basket'),
          ),
        ),
      ),
    );
  }
}