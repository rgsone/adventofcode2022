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

    void update() {
      cycles++;
      if (cycles == 20 || (cycles + 20) % 40 == 0) {
        signalStrengthSum += cycles * regX;
      }
    }

    switch (instruction.first) {
      case 'noop':
        update();
        break;
      case 'addx':
        update();
        update();
        regX += int.parse(instruction.last);
        break;
    }
  });

  print('part 01 : $signalStrengthSum');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<String> input) {
  var cycles = 1;
  var regX = 1;
  var pixels = List<List<String>>.generate(
      6, (index) => List<String>.generate(40, (index) => '.'));

  input.forEach((line) {
    var instruction = line.split(' ');

    void update() {
      var col = (cycles - 1) % 40;
      var row = (cycles / 40).ceil() - 1;

      if (col >= regX - 1 && col <= regX + 1)
        pixels[row][col] = '#';
      else
        pixels[row][col] = '.';

      cycles++;
    }

    switch (instruction.first) {
      case 'noop':
        update();
        break;
      case 'addx':
        update();
        update();
        regX += int.parse(instruction.last);
        break;
    }
  });

  print('part 02');
  pixels.forEach((row) => print(row.join()));
}
