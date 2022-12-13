import 'dart:io';

void run() {
  const filename = 'lib\\d12\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  print('Day 12');
  resolvePart1(input);
  resolvePart2(input);
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePart1(List<String> input) {
  var result = 0;
  var grid = <List<String>>[];
  Position start = Position(0, 0, 0);

  for (int i = 0; i < input.length; i++) {
    var cols = input[i].split('');
    var startIndex = cols.indexWhere((e) => e == 'S');
    if (startIndex > -1) start.set(i, startIndex, 0);
    grid.add(cols);
  }

  var rows = grid.length;
  var cols = grid.first.length;
  var queue = <Position>[];
  var visited = <Position>{};
  var directions = <List<int>>[
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1]
  ];

  queue.add(start);
  visited.add(start);

  while (queue.isNotEmpty) {
    var cur = queue.removeAt(0);

    for (var dir in directions) {
      var nRow = cur.row + dir[0];
      var nCol = cur.col + dir[1];

      if (nRow < 0 || nRow >= rows || nCol < 0 || nCol >= cols) continue;

      if ((getHeight(grid[nRow][nCol]) - getHeight(grid[cur.row][cur.col])) > 1)
        continue;

      if (visited.any((e) => e.row == nRow && e.col == nCol)) continue;

      var n = Position(nRow, nCol, cur.steps + 1);
      visited.add(n);

      if (grid[n.row][n.col] == 'E') {
        result = n.steps;
        break;
      }

      queue.add(n);
    }
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

int getHeight(String letter) {
  return 'SabcdefghijklmnopqrstuvwxyzE'.indexOf(letter);
}

class Position {
  int row;
  int col;
  int steps;

  Position(this.row, this.col, this.steps);

  void set(int row, int col, [int? height]) {
    this.row = row;
    this.col = col;
    this.steps = height ?? this.steps;
  }

  Position copy() {
    return Position(this.row, this.col, this.steps);
  }

  String toString() => 'Pos[$row,$col](steps:$steps)';
}
