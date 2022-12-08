import 'dart:io';

void run() {
  const filename = 'lib\\d05\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  var stacksInput = input.takeWhile((value) => value.isNotEmpty).toList();
  var instructions =
      input.skipWhile((value) => !value.startsWith('move')).toList();
  print('Day 05');
  resolvePuzzle01(createStacks(stacksInput), instructions);
  resolvePuzzle02(createStacks(stacksInput), instructions);
}

List<List<String>> createStacks(List<String> stacksInput) {
  var stackLines = stacksInput.reversed.toList();
  var stackCount = stackLines.removeAt(0).trim().split(RegExp(r'(\s)+')).length;
  var stacks = List<List<String>>.generate(stackCount, (index) => <String>[]);
  stackLines.forEach((stack) {
    for (int i = 1; i < stack.length; i += 4) {
      if (stack.codeUnitAt(i) != 32) {
        stacks[i ~/ 4].add(String.fromCharCode(stack.codeUnitAt(i)));
      }
    }
  });

  return stacks;
}

var regex =
    RegExp(r'^move ([0-9]+) from ([0-9]+) to ([0-9]+)$', multiLine: false);

void resolvePuzzle01(List<List<String>> stacks, List<String> instructions) {
  var result = '';

  instructions.forEach((element) {
    var crateCount = int.parse(regex.firstMatch(element)!.group(1)!);
    var stackFrom = int.parse(regex.firstMatch(element)!.group(2)!) - 1;
    var stackTo = int.parse(regex.firstMatch(element)!.group(3)!) - 1;

    for (int i = 0; i < crateCount; i++) {
      stacks[stackTo].add(stacks[stackFrom].removeLast());
    }
  });

  stacks.forEach((element) {
    result += element.last;
  });

  print('part 01 : $result');
}

void resolvePuzzle02(List<List<String>> stacks, List<String> instructions) {
  var result = '';

  instructions.forEach((element) {
    var crateCount = int.parse(regex.firstMatch(element)!.group(1)!);
    var stackFrom = int.parse(regex.firstMatch(element)!.group(2)!) - 1;
    var stackTo = int.parse(regex.firstMatch(element)!.group(3)!) - 1;
    var crates = <String>[];

    for (int i = 0; i < crateCount; i++) {
      crates.add(stacks[stackFrom].removeLast());
    }

    stacks[stackTo].addAll(crates.reversed);
  });

  stacks.forEach((element) {
    result += element.last;
  });

  print('part 02 : $result');
}
