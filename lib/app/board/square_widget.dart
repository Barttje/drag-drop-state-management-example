import 'package:drag_drop_state_management/app/board/board_view_model.dart';
import 'package:drag_drop_state_management/app/board/checker_widget.dart';
import 'package:drag_drop_state_management/app/model/checker.dart';
import 'package:drag_drop_state_management/app/model/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

class SquareWidget extends HookWidget {
  final Square square;

  SquareWidget(this.square);

  Color getColor(bool willAccept) {
    if (willAccept) {
      return Colors.brown[300]!;
    }

    if (square.coordinate.x % 2 == square.coordinate.y % 2) {
      return Colors.brown[500]!;
    }
    return Colors.brown[100]!;
  }

  @override
  Widget build(BuildContext context) {
    final willAccept = useState(false);
    List<Checker> checking = useProvider(checkers);
    Checker? checkerOnSquare = checking
        .firstWhereOrNull((element) => element.coordinate == square.coordinate);
    return DragTarget(
      builder: (BuildContext context, List<dynamic> candidateData,
          List<dynamic> rejectedData) {
        return Container(
            child: checkerOnSquare != null && !checkerOnSquare.isDragging
                ? CheckerWidget(checkerOnSquare)
                : Container(),
            color: getColor(willAccept.value));
      },
      onWillAccept: (data) {
        willAccept.value = checkerOnSquare == null;
        return checkerOnSquare == null;
        ;
      },
      onLeave: (data) {
        willAccept.value = false;
      },
      onAccept: (Checker data) {
        willAccept.value = false;
        context.read(checkers.notifier).finishDrag(data, square.coordinate);
      },
    );
  }
}
