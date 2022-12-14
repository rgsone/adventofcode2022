import 'dart:convert';
import 'dart:io';
import 'dart:math';

void run() {
  const filename = 'lib\\d13\\input.txt';
  File file = File(filename);
  var input = file.readAsStringSync().split("\r\n\r\n");
  print('Day 13');
  resolvePart1(input);
  resolvePart2(input);
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePart1(List<String> input) {
  var result = 0;

  for (int i = 0; i < input.length; i++) {
    var split = input[i].split('\r\n');
    var left = jsonDecode(split[0]);
    var right = jsonDecode(split[1]);
    result += compPair(left, right) > 0 ? i + 1 : 0;
  }

  print('part 01 : $result');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePart2(List<String> input) {
  print('part 02 : 0');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

int compPair(left, right) {
  if (left is List && right is List) {
    var len = min<int>(left.length, right.length);

    for (int i = 0; i < len; i++) {
      var comp = compPair(left[i], right[i]);
      if (comp != 0) return comp;
    }

    if (left.length < right.length) return 1;
    if (right.length < left.length) return -1;

    return 0;
  } else if (left is int && right is List) {
    return compPair([left], right);
  } else if (left is List && right is int) {
    return compPair(left, [right]);
  } else if (left is int && right is int) {
    return left < right ? 1 : (left > right ? -1 : 0);
  }

  return 0;
}
