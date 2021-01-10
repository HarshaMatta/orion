import 'package:flutter/material.dart';

class OrionHomePage extends StatefulWidget {
  OrionHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  OrionHomePageState createState() => OrionHomePageState();
}

class OrionHomePageState extends State<OrionHomePage> {

  void createInputPopUp() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'this text is irrelavent',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createInputPopUp,
        tooltip:  'ShowDialog',
        child: Icon(Icons.add),
      ),
        // child: Icon(Icons.add), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
