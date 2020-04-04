import 'words.dart';

import 'package:flutter/material.dart';
import 'dart:math';

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
                    containerHeight: containerHeight,
                    duration: Duration(seconds: 10),
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

typedef ContainerBuilder = Widget Function(int a);

class Spinner extends StatefulWidget {
  final int containerCount;
  final double containerHeight;
  final Duration duration;

  // Builder function that takes in an int and returns a fixed size container
  final ContainerBuilder builder;
  final Curve curve;

  Spinner({
    @required this.containerCount,
    @required this.containerHeight,
    @required this.builder,
    @required this.duration,
    this.curve: Curves.easeInOutCubic,
  });

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _controller, curve: widget.curve);
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

  Iterable<int> get positiveIntegers sync* {
    int i = 0;
    while (true) yield i++;
  }

  Widget transformColumn(double curveValue) {
    double rawOffset = _curve.value * 50 * widget.containerHeight;
    int start = ((rawOffset / widget.containerHeight)).floor();

    _column = Column(
        children: positiveIntegers
            .skip(start)
            .take(widget.containerCount)
            .map(widget.builder)
            .toList());

    _offset = -rawOffset % widget.containerHeight;
    var translate =
        Transform.translate(offset: Offset(0, _offset), child: _column);

    _transformed =
        Transform.scale(scale: (_curve.value * 3) + 1.5, child: translate);
    return _transformed;
  }

  @override
  Widget build(BuildContext context) {
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
