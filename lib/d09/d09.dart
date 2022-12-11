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
  print('part 01 : ${simRope(input, 2)}');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<String> input) {
  print('part 02 : ${simRope(input, 10)}');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

int simRope(List<String> input, int knotsCount) {
  var knots = List<Point<int>>.generate(knotsCount, (index) => Point(0, 0));
  var tailVisited = <Point<int>>{Point(0, 0)};

  Point<int> getDirectionPoint(String direction) {
    var x = direction == 'R' ? 1 : (direction == 'L' ? -1 : 0);
    var y = direction == 'U' ? 1 : (direction == 'D' ? -1 : 0);
    return Point(x, y);
  }

  void updateRope(Point<int> dir) {
    knots[0] += dir;

    for (int i = 1; i < knots.length; i++) {
      var head = knots[i - 1];
      var tail = knots[i];

      if ((head.x - tail.x).abs() > 1 || (head.y - tail.y).abs() > 1) {
        var xDir =
            head.x == tail.x ? 0 : (head.x - tail.x) ~/ (head.x - tail.x).abs();
        var yDir =
            head.y == tail.y ? 0 : (head.y - tail.y) ~/ (head.y - tail.y).abs();
        knots[i] += Point(xDir, yDir);
      }
    }
  }

  input.forEach((line) {
    var instruction = line.split(' ');
    var dirPoint = getDirectionPoint(instruction.first);
    var steps = int.parse(instruction.last);

    for (int i = 0; i < steps; i++) {
      updateRope(dirPoint);
      tailVisited.add(Point(knots.last.x, knots.last.y));
    }
  });

  return tailVisited.length;
}
