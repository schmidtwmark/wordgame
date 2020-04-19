import 'words.dart';
import 'package:flutter/material.dart';

class ClueScreen extends StatelessWidget {
  static const int STARTING_WORDS = 11;

  String clue = "";
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        // Display word
        return Scaffold(
          body: Center(child: Text(clue)),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text("Give a Clue"),
            ),
            body: Padding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Type a one word clue and rotate your phone to lock it in",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        maxLines: 1,
                        autocorrect: false,
                        textAlign: TextAlign.center,
                        // textInputAction: TextInputAction.next,
                        onChanged: (String s) {
                          clue = s;
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                          "Show your clues to your fellow clue givers, and get rid of any duplicate clues",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center))
                ],
              ),
              padding: EdgeInsets.all(20),
            ));
      }
    });
  }
}
