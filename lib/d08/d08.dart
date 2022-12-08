import 'dart:io';

void run() {
  const filename = 'lib\\d08\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  var treeGrid = buildGrid(input);
  print('Day 08');
  resolvePuzzle01(treeGrid);
  resolvePuzzle02(treeGrid);
}

List<List<int>> buildGrid(List<String> input) {
  var grid = <List<int>>[];
  input.forEach((line) {
    grid.add(line.split('').map((e) => int.parse(e)).toList());
  });
  return grid;
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle01(List<List<int>> treeGrid) {
  int result = 0;

  for (int y = 0; y < treeGrid.length; y++) {
    for (int x = 0; x < treeGrid[y].length; x++) {
      if (y == 0 ||
          y == treeGrid.length - 1 ||
          x == 0 ||
          x == treeGrid[y].length - 1) {
        result++;
        continue;
      }

      if (checkWestVisibility(x, y, treeGrid) ||
          checkEastVisibility(x, y, treeGrid) ||
          checkNorthVisibility(x, y, treeGrid) ||
          checkSouthVisibility(x, y, treeGrid)) {
        result++;
      }
    }
  }

  print('part 01 : $result');
}

bool checkWestVisibility(int x, int y, List<List<int>> grid) {
  var row = grid[y];
  for (int i = x - 1; i >= 0; i--) {
    if (row[i] >= row[x]) return false;
  }
  return true;
}

bool checkNorthVisibility(int x, int y, List<List<int>> grid) {
  for (int i = y - 1; i >= 0; i--) {
    if (grid[i][x] >= grid[y][x]) return false;
  }
  return true;
}

bool checkEastVisibility(int x, int y, List<List<int>> grid) {
  var row = grid[y];
  for (int i = x + 1; i < row.length; i++) {
    if (row[i] >= row[x]) return false;
  }
  return true;
}

bool checkSouthVisibility(int x, int y, List<List<int>> grid) {
  for (int i = y + 1; i < grid.length; i++) {
    if (grid[i][x] >= grid[y][x]) return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

void resolvePuzzle02(List<List<int>> treeGrid) {
  int result = 0;

  for (int y = 0; y < treeGrid.length; y++) {
    for (int x = 0; x < treeGrid[y].length; x++) {
      var score = scenicScore(x, y, treeGrid);
      result = result < score ? score : result;
    }
  }

  print('part 02 : $result');
}

int scenicScore(int x, int y, List<List<int>> grid) {
  var sumWest = 0;
  var sumSouth = 0;
  var sumEast = 0;
  var sumNorth = 0;

  for (int i = x + 1; i < grid[y].length; i++) {
    sumWest++;
    if (grid[y][i] >= grid[y][x]) break;
  }

  for (int i = y + 1; i < grid.length; i++) {
    sumSouth++;
    if (grid[i][x] >= grid[y][x]) break;
  }

  for (int i = x - 1; i >= 0; i--) {
    sumEast++;
    if (grid[y][i] >= grid[y][x]) break;
  }

  for (int i = y - 1; i >= 0; i--) {
    sumNorth++;
    if (grid[i][x] >= grid[y][x]) break;
  }

  return sumWest * sumSouth * sumEast * sumNorth;
}
