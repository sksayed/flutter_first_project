import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  final String text;

  const AnotherPage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Another Page"),),
      body: Container(
        color: Colors.amber,
        child: Center(child: Text(text)),
      ),
    );
  }

}