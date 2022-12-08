import 'dart:io';

// Puzzle 1
// A: Rock, B: Paper, C: Scissors
// X: Rock(1), Y: Paper(2), Z: Scissors(3)
// Lose(0), Draw(3), Win(6)

// Puzzle 2
// A: Rock, B: Paper, C: Scissors
// X: Lose(0), Y: Draw(3), Z: Win(6)
// Rock(1), Paper(2), Scissors(3)

Map<String, List<int>> scores = {
  'A X': [4, 3],
  'A Y': [8, 4],
  'A Z': [3, 8],
  'B X': [1, 1],
  'B Y': [5, 5],
  'B Z': [9, 9],
  'C X': [7, 2],
  'C Y': [2, 6],
  'C Z': [6, 7],
};

void run() {
  const filename = 'lib\\d02\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 02');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

void resolvePuzzle01(List<String> input) {
  int result = 0;
  input.forEach((elem) {
    result += scores[elem]?[0] ?? 0;
  });
  print('part 01 : $result');
}

void resolvePuzzle02(List<String> input) {
  int result = 0;
  input.forEach((elem) {
    result += scores[elem]?[1] ?? 0;
  });
  print('part 02 : $result');
}
