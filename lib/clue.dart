import 'words.dart';
import 'package:flutter/material.dart';

class ClueScreen extends StatelessWidget {
  static const int STARTING_WORDS = 11;

  String clue = "Clue";
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        // Display word
        return Scaffold(
          body: Center(child: Text(clue, style: TextStyle(fontSize: 144))),
        );
      } else {
        TextEditingController controller = TextEditingController()..text = clue;
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
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        autofocus: true,
                        controller: controller,
                        maxLines: 1,
                        autocorrect: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                        onChanged: (String s) {
                          String newString = s.replaceAll(" ", "");
                          controller.text = newString;
                          clue = newString;
                        },
                      )),
                ],
              ),
              padding: EdgeInsets.all(20),
            ));
      }
    });
  }
}
