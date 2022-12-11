import 'dart:io';

void run() {
  const filename = 'lib\\d10\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 10');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle01(List<String> input) {
  var cycles = 0;
  var regX = 1;
  var signalStrengthSum = 0;

  input.forEach((line) {
    var instruction = line.split(' ');

    void checkCycleCount() {
      if (cycles == 20 || (cycles + 20) % 40 == 0) {
        signalStrengthSum += cycles * regX;
      }
    }

    switch (instruction.first) {
      case 'noop':
        cycles++;
        checkCycleCount();
        break;
      case 'addx':
        cycles++;
        checkCycleCount();
        cycles++;
        checkCycleCount();
        regX += int.parse(instruction.last);
        break;
    }
  });

  print('part 01 : $signalStrengthSum');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<String> input) {
  print('part 02 : 0');
}
