import 'dart:math';

import 'package:flutter/material.dart';
import 'run.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool running = false;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} ${running ? "- Running" : ""}'),
      ),
      body: Center(
        child: AnimatedBuilder(
          child: FlutterLogo(size: 200),
          animation: controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: controller.value * 2 * pi,
              child: child,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            running = true;
          });
          await run();
          setState(() {
            running = false;
          });
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}
