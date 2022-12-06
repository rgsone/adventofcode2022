import 'dart:io';

void run() {
  const filename = 'lib\\d04\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 04');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

void resolvePuzzle01(List<String> input) {
  int result = 0;

  input.forEach((element) {
    var assignments = element.split(',');
    var left = assignments[0].split('-').map((e) => int.parse(e)).toList();
    var right = assignments[1].split('-').map((e) => int.parse(e)).toList();

    if ((left[0] <= right[0] && left[1] >= right[1]) ||
        (right[0] <= left[0] && right[1] >= left[1])) {
      result++;
    }
  });

  print('puzzle 01 : $result');
}

void resolvePuzzle02(List<String> input) {
  int result = 0;

  input.forEach((element) {
    var assignments = element.split(',');
    var left = assignments[0].split('-').map((e) => int.parse(e)).toList();
    var right = assignments[1].split('-').map((e) => int.parse(e)).toList();

    if ((left[0] <= right[1] && right[0] <= left[1])) {
      result++;
    }
  });

  print('puzzle 02 : $result');
}
