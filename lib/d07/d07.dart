import 'dart:io';

void run() {
  const filename = 'lib\\d07\\input.txt';
  File file = File(filename);
  var input = file.readAsLinesSync();
  var dirTree = buildTree(input);
  print('Day 07');
  resolvePuzzle01(dirTree);
  resolvePuzzle02(dirTree);
}

Node buildTree(List<String> input) {
  Node dirTree = Node(NodeType.directory, '/', 0, null);
  var currentDir = dirTree;

  input.forEach((line) {
    if (line.startsWith('\$ cd')) {
      currentDir = parseCommand(line, currentDir, dirTree);
    } else if (line.startsWith('dir ')) {
      parseDir(line, currentDir);
    } else if (line.startsWith(RegExp(r'^[0-9]+ '))) {
      parseFile(line, currentDir);
    }
  });

  return dirTree;
}

Node parseCommand(String input, Node currentDir, Node dirTree) {
  var destDirName = input.split(' ')[2];
  if (destDirName == '/') {
    currentDir = dirTree;
  } else if (destDirName == '..') {
    currentDir = currentDir.parent ?? currentDir;
  } else if (destDirName.contains(RegExp(r'^[a-z]+$'))) {
    currentDir = currentDir.children.firstWhere(
        (node) => node.name == destDirName,
        orElse: () => currentDir);
  }

  return currentDir;
}

void parseDir(String input, Node currentDir) {
  currentDir.children
      .add(Node(NodeType.directory, input.split(' ').last, 0, currentDir));
}

void parseFile(String input, Node currentDir) {
  var infos = input.split(' ');
  currentDir.children
      .add(Node(NodeType.file, infos.last, int.parse(infos.first), currentDir));
}

enum NodeType { directory, file }

class Node {
  final NodeType type;
  final String name;
  int size;
  Node? parent;
  List<Node> children = [];

  Node(this.type, this.name, this.size, this.parent);

  int getTotalSize() {
    return type == NodeType.file
        ? size
        : children.fold(0, (prev, node) => prev + node.getTotalSize());
  }
}

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

void resolvePuzzle01(Node dirTree) {
  print('part 01 : ${getDirTotalSizes(dirTree)}');
}

int getDirTotalSizes(Node node) {
  int size = 0;
  int currentNodeSize = node.getTotalSize();

  if (node.type == NodeType.directory && currentNodeSize < 100000) {
    size += currentNodeSize;
  }

  for (Node nodeChild in node.children) {
    size += getDirTotalSizes(nodeChild);
  }

  return size;
}

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

void resolvePuzzle02(Node dirTree) {
  var usedSpace = dirTree.getTotalSize();
  var unusedSpace = 70000000 - usedSpace;
  var neededUnusedSpace = 30000000;
  var neededSpaceToDelete = neededUnusedSpace - unusedSpace;
  var result =
      bestAdmissibleDirectorySize(dirTree, neededSpaceToDelete, usedSpace);

  print('part 02 : $result');
}

int bestAdmissibleDirectorySize(Node node, neededSpaceToDelete, smallestDir) {
  if (node.type != NodeType.directory) return smallestDir;

  int nodeSize = node.getTotalSize();
  if (nodeSize >= neededSpaceToDelete) smallestDir = nodeSize;

  for (Node nodeChild in node.children) {
    int childSize = bestAdmissibleDirectorySize(
        nodeChild, neededSpaceToDelete, smallestDir);
    smallestDir = childSize < smallestDir ? childSize : smallestDir;
  }

  return smallestDir;
}
