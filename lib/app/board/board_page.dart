import 'package:drag_drop_state_management/app/board/square_widget.dart';
import 'package:drag_drop_state_management/app/model/coordinate.dart';
import 'package:drag_drop_state_management/app/model/square.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {
  final List<Square> squares = SquareInitializer.squares();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: new NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(4),
      crossAxisCount: 8,
      children: squares.map((square) => SquareWidget(square)).toList(),
    );
  }
}

class SquareInitializer {
  static List<Square> squares() {
    List<Square> squares = [];
    for (var y = 0; y < 8; y++) {
      for (var x = 0; x < 8; x++) {
        squares.add(Square(Coordinate(x, y)));
      }
    }
    return squares;
  }
}
