import 'dart:convert';
import 'dart:io';

void run() {
  const filename = 'lib\\d11\\input.txt';
  File file = File(filename);
  var input = file.readAsStringSync().split('\r\n\r\n');
  print('Day 11');
  resolvePuzzle01(input);
  resolvePuzzle02(input);
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle01(List<String> input) {
  var monkeys = <Monkey>[];

  input.forEach((monkeyCarac) {
    monkeys.add(Monkey.parseCarac(monkeyCarac));
  });

  for (int i = 0; i < 20; i++) {
    for (Monkey monkey in monkeys) {
      monkey.inspect(monkeys, true);
    }
  }

  monkeys.sort((a, b) => b.inspectedCount.compareTo(a.inspectedCount));

  print('part 01 : ${monkeys[0].inspectedCount * monkeys[1].inspectedCount}');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<String> input) {
  var monkeys = <Monkey>[];

  input.forEach((monkeyCarac) {
    monkeys.add(Monkey.parseCarac(monkeyCarac));
  });

  var commonMod = monkeys.map((e) => e.divNumber).reduce((v1, v2) => v1 * v2);

  for (int i = 0; i < 10000; i++) {
    for (Monkey monkey in monkeys) {
      monkey.inspect(monkeys, false, commonMod);
    }
  }

  monkeys.sort((a, b) => b.inspectedCount.compareTo(a.inspectedCount));

  print('part 02 : ${monkeys[0].inspectedCount * monkeys[1].inspectedCount}');
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

class Monkey {
  int id;
  List<int> items;
  int Function(int) testOperation;
  int divNumber;
  int trueThrowTarget;
  int falseThrowTarget;
  int inspectedCount = 0;

  Monkey(this.id, this.items, this.testOperation, this.divNumber,
      this.trueThrowTarget, this.falseThrowTarget);

  factory Monkey.parseCarac(String carac) {
    var lines = LineSplitter.split(carac).toList();
    var id =
        int.parse(RegExp(r'Monkey ([0-9]+):').firstMatch(lines.first)![1]!);
    List<int> items =
        lines[1].trim().split(': ').last.split(', ').map(int.parse).toList();
    var testOperation = getTestOperationFunc(lines[2].trim().split(' = ').last);
    var divNumber = int.parse(lines[3].trim().split(' ').last);
    var trueThrowTarget = int.parse(lines[4].trim().split(' ').last);
    var falseThrowTarget = int.parse(lines[5].trim().split(' ').last);

    return Monkey(
        id, items, testOperation, divNumber, trueThrowTarget, falseThrowTarget);
  }

  static int Function(int) getTestOperationFunc(String expression) {
    var tokens = expression.split(' ').toList(growable: false);
    var leftValue = int.tryParse(tokens.first);
    var operator = tokens[1];
    var rightValue = int.tryParse(tokens.last);

    int testOperation(int oldValue) {
      switch (operator) {
        case '+':
          return (leftValue ?? oldValue) + (rightValue ?? oldValue);
        case '*':
          return (leftValue ?? oldValue) * (rightValue ?? oldValue);
        default:
          return oldValue;
      }
    }

    return testOperation;
  }

  void inspect(List<Monkey> monkeys, bool part1, [int? commonMod]) {
    while (items.isNotEmpty) {
      var item = items.removeAt(0);
      var worryLvl = part1
          ? (testOperation(item) / 3).floor()
          : testOperation(item) % commonMod!;

      if (worryLvl % divNumber == 0) {
        monkeys[trueThrowTarget].items.add(worryLvl);
      } else {
        monkeys[falseThrowTarget].items.add(worryLvl);
      }

      inspectedCount++;
    }
  }
}
