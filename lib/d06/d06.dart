import 'dart:io';

void run() {
  const filename = 'lib\\d06\\input.txt';
  File file = File(filename);
  var input = file.readAsStringSync();
  print('Day 06');
  resolvePart1(input);
  resolvePart2(input);
}

void resolvePart1(String input) {
  int result = resolve(input, 4);
  print('part 01 : $result');
}

void resolvePart2(String input) {
  int result = resolve(input, 14);
  print('part 02 : $result');
}

int resolve(String input, int markerLength) {
  var buffer = <int>[];
  var isUnique = true;

  for (var char in input.runes) {
    buffer.add(char);
    if (buffer.length >= markerLength) {
      var chunk = buffer.sublist(buffer.length - markerLength, buffer.length);
      chunk.sort();
      isUnique = true;

      for (int i = 1; i < chunk.length; i++) {
        if (chunk[i - 1] == chunk[i]) {
          isUnique = false;
        }
      }

      if (isUnique) {
        break;
      }
    }
  }

  return buffer.length;
}
