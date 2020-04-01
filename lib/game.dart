import 'package:flutter/material.dart';
import 'dart:math';

class GuessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        // Begin word animation
        return Scaffold(body: Center(child: Spinner()));
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text("Guess a Word"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Flip your phone to landscape and show it to the other players to generate a word")
              ],
            ));
      }
    });
  }
}

class Spinner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _curve;
  final List<String> _words = const [
    "Dog",
    "Cat",
    "Batman",
    "Coaster",
    "Seashell",
    "Laptop",
    "Couch",
    "Chair",
    "Lamp",
    "Stairs",
    "Picture",
    "TikTok",
    "Driveway",
    "Mailbox",
    "Fence",
    "Popcorn",
    "Cookie",
    "Egg",
    "Purse",
    "Rug"
  ]; //.map((word) => Text(word, style: TextStyle(fontSize: 24)));

  static const int STARTING_WORDS = 10;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> getSubset(List<String> list, int begin, int end) {
    if (begin <= end) {
      return list.getRange(begin, end).toList();
    } else {
      return list.getRange(begin, list.length).toList()
        ..addAll(list.getRange(0, end));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.8;
    print(height);

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        // 10 Texts on the screen at the start
        // print(
        //     "Controller value ${_controller.value}, curve value ${_curve.value}");
        double rawOffset = _curve.value * 5000;
        int wordIndex =
            (rawOffset / (height / STARTING_WORDS) % _words.length).floor();
        int end = (wordIndex + STARTING_WORDS) % _words.length;
        var column = Column(
            children: getSubset(_words, wordIndex, end)
                .map((word) => Text(word,
                    style: TextStyle(fontSize: height / STARTING_WORDS)))
                .toList());

        var translate = Transform.translate(
          offset: Offset(0, -rawOffset % (height / STARTING_WORDS)),
          child: column,
        );
        // return translate;
        return Transform.scale(scale: _curve.value + 1, child: translate);
      },
    );
  }
}
