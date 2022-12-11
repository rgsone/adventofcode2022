import 'dart:io';
import 'dart:math';

void run() {
  const filename = 'lib\\d09\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 09');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle01(List<String> input) {
  var head = Point(0, 0);
  var tail = Point(0, 0);
  var tailVisited = <Point<int>>{Point(0, 0)};

  Point<int> getDirectionPoint(String direction) {
    if (direction == 'R')
      return Point(1, 0);
    else if (direction == 'D')
      return Point(0, -1);
    else if (direction == 'L')
      return Point(-1, 0);
    else if (direction == 'U') return Point(0, 1);

    return Point(0, 0);
  }

  void updateRope(Point<int> dir) {
    head += dir;

    if ((head.x - tail.x).abs() > 1 || (head.y - tail.y).abs() > 1) {
      var xDir =
          head.x == tail.x ? 0 : (head.x - tail.x) ~/ (head.x - tail.x).abs();
      var yDir =
          head.y == tail.y ? 0 : (head.y - tail.y) ~/ (head.y - tail.y).abs();
      tail += Point(xDir, yDir);
    }
  }

  input.forEach((line) {
    var instruction = line.split(' ');
    var steps = int.parse(instruction.last);
    var dirPoint = getDirectionPoint(instruction.first);

    for (int i = 0; i < steps; i++) {
      updateRope(dirPoint);
      tailVisited.add(Point(tail.x, tail.y));
    }
  });

  print('part 01 : ${tailVisited.length}');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<String> input) {
  int result = 0;
  print('part 02 : $result');
}
