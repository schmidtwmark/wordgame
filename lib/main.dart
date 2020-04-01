import 'package:flutter/material.dart';
import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Game"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Guess a Word"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GuessScreen()));
              },
            ),
            RaisedButton(
              child: Text("Give a Clue"),
              onPressed: () {
                // TODO go to Clue screen
              },
            ),
            RaisedButton(
              child: Text("Rules"),
              onPressed: () {
                // TODO go to rules screen
              },
            )
          ],
        ),
      ),
    );
  }
}
