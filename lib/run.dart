import 'dart:async';

import 'dart:math';

Future<void> run() async {
  DateTime dt = DateTime.now();
  // run1();
  await run2();
  print((DateTime.now().millisecondsSinceEpoch - dt.millisecondsSinceEpoch) / 1000);
}

void run1() async {
  String str = "";
  for (var i = 0; i < 40000; i++) {
    str = '$str $i';
  }
  print(str);
}

Future<void> run2() async {
  String str = "";
  await runLoop(
    length: 40000,
    execute: (index) => str = '$str $index',
  );
  print(str);
}

Future<bool> runLoop({
  int length,
  Function(int index) execute,
  int chunkLength = 25,
}) {
  final completer = new Completer<bool>();
  Function(int i) _exec;
  _exec = (i) {
    if (i >= length) return completer.complete(true);
    for (int j = i; j < min(length, i + chunkLength); j++) {
      execute(j);
    }
    Future.delayed(Duration(milliseconds: 0), () {
      _exec(i + chunkLength);
    });
  };
  _exec(0);
  return completer.future;
}
