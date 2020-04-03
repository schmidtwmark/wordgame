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

class Spinner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _curve;
  Widget _column;
  Widget _transformed;
  bool _spinComplete = false;
  double _offset = 0;
  double _integral = 0;
  double _containerHeight;
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
    "Rug",
    "New"
  ];

  static const int STARTING_WORDS = 11;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _controller.forward();
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          print("Marking spin complete!");
          _spinComplete = true;
        });
      }
    });
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

  Widget transformColumn(double curveValue) {
    double rawOffset = _curve.value * 50 * _containerHeight;
    int wordIndex = ((rawOffset / _containerHeight) % _words.length).floor();
    int end = (wordIndex + STARTING_WORDS) % _words.length;

    _column = Column(
        children: getSubset(_words, wordIndex, end)
            .map((word) => Container(
                height: _containerHeight.toDouble(),
                color: Color.fromARGB(255, 120, _words.indexOf(word) * 10, 120),
                child: Center(
                    child: Text(word,
                        style: TextStyle(fontSize: _containerHeight * .8)))))
            .toList());

    _offset = -rawOffset % _containerHeight;
    _integral += _offset;
    var translate =
        Transform.translate(offset: Offset(0, _offset), child: _column);

    _transformed =
        Transform.scale(scale: (_curve.value * 3) + 1.5, child: translate);
    return _transformed;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    _containerHeight = height / STARTING_WORDS;

    if (!_spinComplete) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return transformColumn(_curve.value);
        },
      );
    } else {
      print("Drawing spin complete!");
      return _transformed;
      // return Center(child: Transform.scale(scale: 3 + 1.5, child: _column));
    }
  }
}
