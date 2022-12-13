import 'dart:io';

void run() {
  const filename = 'lib\\d01\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 01');
  resolvePart1(input);
  resolvePart2(input);
}

void resolvePart1(List<String> input) {
  int currentElfCal = 0;
  int result = 0;

  for (var i = 0; i < input.length; i++) {
    if (input[i].isEmpty || i >= input.length - 1) {
      result = currentElfCal > result ? currentElfCal : result;
      currentElfCal = 0;
      continue;
    }
    currentElfCal += int.parse(input[i]);
  }

  print('part 01 : $result');
}

void resolvePart2(List<String> input) {
  int currentElfCal = 0;
  List<int> calories = [];

  for (var i = 0; i < input.length; i++) {
    if (input[i].isEmpty || i >= input.length - 1) {
      calories.add(currentElfCal);
      currentElfCal = 0;
      continue;
    }
    currentElfCal += int.parse(input[i]);
  }

  calories.sort();
  int result = calories
      .skip(calories.length - 3)
      .reduce((value, element) => value + element);

  print('part 02 : $result');
}
