// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExampleDragTarget extends StatefulWidget {
  @override
  ExampleDragTargetState createState() => ExampleDragTargetState();
}

class ExampleDragTargetState extends State<ExampleDragTarget> {
  Color _color = Colors.grey;

  void _handleAccept(Color data) {
    setState(() {
      _color = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Color>(
      onAccept: _handleAccept,
      builder: (BuildContext context, List<Color> data, List<dynamic> rejectedData) {
        return Container(
          height: 100.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: data.isEmpty ? _color : Colors.grey.shade200,
            border: Border.all(
              width: 3.0,
              color: data.isEmpty ? Colors.white : Colors.blue,
            ),
          ),
        );
      },
    );
  }
}

class Dot extends StatefulWidget {
  const Dot({ Key key, this.color, this.size, this.child, this.tappable = false }) : super(key: key);

  final Color color;
  final double size;
  final Widget child;
  final bool tappable;

  @override
  DotState createState() => DotState();
}
class DotState extends State<Dot> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tappable ? () { setState(() { taps += 1; }); } : null,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(width: taps.toDouble()),
          shape: BoxShape.circle,
        ),
        child: widget.child,
      ),
    );
  }
}

class ExampleDragSource extends StatelessWidget {
  const ExampleDragSource({
    Key key,
    this.color,
    this.heavy = false,
    this.under = true,
    this.child,
  }) : super(key: key);

  final Color color;
  final bool heavy;
  final bool under;
  final Widget child;

  static const double kDotSize = 50.0;
  static const double kHeavyMultiplier = 1.5;
  static const double kFingerSize = 50.0;

  @override
  Widget build(BuildContext context) {
    double size = kDotSize;
    if (heavy)
      size *= kHeavyMultiplier;

    final Widget contents = DefaultTextStyle(
      style: Theme.of(context).textTheme.body1,
      textAlign: TextAlign.center,
      child: Dot(
        color: color,
        size: size,
        child: Center(child: child),
      ),
    );

    Widget feedback = Opacity(
      opacity: 0.75,
      child: contents,
    );

    Offset feedbackOffset;
    DragAnchor anchor;
    if (!under) {
      feedback = Transform(
        transform: Matrix4.identity()
                     ..translate(-size / 2.0, -(size / 2.0 + kFingerSize)),
        child: feedback,
      );
      feedbackOffset = const Offset(0.0, -kFingerSize);
      anchor = DragAnchor.pointer;
    } else {
      feedbackOffset = Offset.zero;
      anchor = DragAnchor.child;
    }

    if (heavy) {
      return LongPressDraggable<Color>(
        data: color,
        child: contents,
        feedback: feedback,
        feedbackOffset: feedbackOffset,
        dragAnchor: anchor,
      );
    } else {
      return Draggable<Color>(
        data: color,
        child: contents,
        feedback: feedback,
        feedbackOffset: feedbackOffset,
        dragAnchor: anchor,
      );
    }
  }
}

class DashOutlineCirclePainter extends CustomPainter {
  const DashOutlineCirclePainter();

  static const int segments = 17;
  static const double deltaTheta = math.pi * 2 / segments; // radians
  static const double segmentArc = deltaTheta / 2.0; // radians
  static const double startOffset = 1.0; // radians

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.shortestSide / 2.0;
    final Paint paint = Paint()
      ..color = const Color(0xFF000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 10.0;
    final Path path = Path();
    final Rect box = Offset.zero & size;
    for (double theta = 0.0; theta < math.pi * 2.0; theta += deltaTheta)
      path.addArc(box, theta + startOffset, segmentArc);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DashOutlineCirclePainter oldDelegate) => false;
}

class MovableBall extends StatelessWidget {
  const MovableBall(this.position, this.ballPosition, this.callback);

  final int position;
  final int ballPosition;
  final ValueChanged<int> callback;

  static final GlobalKey kBallKey = GlobalKey();
  static const double kBallSize = 50.0;

  @override
  Widget build(BuildContext context) {
    final Widget ball = DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.body1,
      textAlign: TextAlign.center,
      child: Dot(
        key: kBallKey,
        color: Colors.blue.shade700,
        size: kBallSize,
        tappable: true,
        child: const Center(child: Text('BALL')),
      ),
    );
    final Widget dashedBall = Container(
      width: kBallSize,
      height: kBallSize,
      child: const CustomPaint(
        painter: DashOutlineCirclePainter()
      ),
    );
    if (position == ballPosition) {
      return Draggable<bool>(
        data: true,
        child: ball,
        childWhenDragging: dashedBall,
        feedback: ball,
        maxSimultaneousDrags: 1,
      );
    } else {
      return DragTarget<bool>(
        onAccept: (bool data) { callback(position); },
        builder: (BuildContext context, List<bool> accepted, List<dynamic> rejected) {
          return dashedBall;
        },
      );
    }
  }
}

class DragAndDropApp extends StatefulWidget {
  @override
  DragAndDropAppState createState() => DragAndDropAppState();
}

class DragAndDropAppState extends State<DragAndDropApp> {
  int position = 1;

  void moveBall(int newPosition) {
    setState(() { position = newPosition; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop Flutter Demo'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ExampleDragSource(
                  color: Colors.yellow.shade300,
                  under: true,
                  heavy: false,
                  child: const Text('under'),
                ),
                ExampleDragSource(
                  color: Colors.green.shade300,
                  under: false,
                  heavy: true,
                  child: const Text('long-press above'),
                ),
                ExampleDragSource(
                  color: Colors.indigo.shade300,
                  under: false,
                  heavy: false,
                  child: const Text('above'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: ExampleDragTarget()),
                Expanded(child: ExampleDragTarget()),
                Expanded(child: ExampleDragTarget()),
                Expanded(child: ExampleDragTarget()),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MovableBall(1, position, moveBall),
                MovableBall(2, position, moveBall),
                MovableBall(3, position, moveBall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS. https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(MaterialApp(
    title: 'Drag and Drop Flutter Demo',
    home: DragAndDropApp(),
  ));
}