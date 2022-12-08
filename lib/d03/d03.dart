import 'dart:io';

void run() {
  const filename = 'lib\\d03\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 03');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

void resolvePuzzle01(List<String> input) {
  int result = 0;

  input.forEach((elem) {
    var middlePos = elem.length ~/ 2;
    var left = elem.substring(0, middlePos);
    var right = elem.substring(middlePos);
    var duplicate = '';

    for (int value in left.runes) {
      var char = String.fromCharCode(value);
      if (right.indexOf(char) > -1) {
        duplicate = char;
        break;
      }
    }

    result += chars.indexOf(duplicate) + 1;
  });

  print('part 01 : $result');
}

void resolvePuzzle02(List<String> input) {
  int result = 0;
  String badge = '';
  List<List<String>> groups = chunk(input, 3);
  groups.forEach((rucksacks) {
    rucksacks[0].split('').forEach((letter) {
      if (rucksacks[1].indexOf(letter) > -1 &&
          rucksacks[2].indexOf(letter) > -1) {
        badge = letter;
      }
    });
    result += chars.indexOf(badge) + 1;
  });
  print('part 02 : $result');
}

List<List<String>> chunk(List<String> list, int chunkSize) {
  List<List<String>> chunks = [];
  int len = list.length;
  for (var i = 0; i < len; i += chunkSize) {
    int size = i + chunkSize;
    chunks.add(list.sublist(i, size > len ? len : size));
  }
  return chunks;
}
