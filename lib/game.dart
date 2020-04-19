import 'words.dart';
import 'package:flutter/material.dart';
import 'package:spinner/spinner.dart';

class GuessScreen extends StatelessWidget {
  static const int STARTING_WORDS = 11;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        // Begin word animation
        var height = MediaQuery.of(context).size.height;
        var containerHeight = height / STARTING_WORDS;

        return Scaffold(
            body: Center(
                child: Spinner(
                    containerCount: STARTING_WORDS,
                    containerSize: containerHeight,
                    animationSpeed: 50,
                    zoomFactor: 4,
                    duration: Duration(seconds: 5),
                    spinDirection: SpinnerDirection.up,
                    builder: (index) => Container(
                        height: containerHeight.toDouble(),
                        color: Color.fromARGB(
                            255, 120, ((index % words.length) * 10) % 255, 120),
                        child: Center(
                            child: Text(words[index % words.length],
                                style: TextStyle(
                                    fontSize: containerHeight * .8)))))));
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text("Guess a Word"),
            ),
            body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Flip your phone to landscape and show it to the other players to generate a word",
                      style: TextStyle(fontSize: 40),
                    )
                  ],
                )));
      }
    });
  }
}
