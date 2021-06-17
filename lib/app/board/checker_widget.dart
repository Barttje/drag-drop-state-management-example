import 'package:drag_drop_state_management/app/board/board_view_model.dart';
import 'package:drag_drop_state_management/app/model/checker.dart';
import 'package:drag_drop_state_management/app/model/player_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckerWidget extends HookWidget {
  final Checker checker;

  int allowMove(PlayerType playerType) {
    if (playerType == checker.type) {
      return 1;
    }
    return 0;
  }

  getColor() {
    if (PlayerType.WHITE == checker.type) {
      return Colors.white;
    }
    return Colors.black;
  }

  const CheckerWidget(this.checker);

  @override
  Widget build(BuildContext context) {
    final current = useProvider(currentPlayer);

    return Draggable(
      data: checker,
      maxSimultaneousDrags: allowMove(current),
      onDragStarted: () {
        context.read(checkers.notifier).startDrag(checker);
      },
      onDraggableCanceled: (a, b) {
        context.read(checkers.notifier).cancelDrag(checker);
      },
      feedback: Container(
        child: Icon(
          Icons.circle,
          color: getColor(),
          size: 35,
        ),
      ),
      child: Container(
        child: Icon(
          Icons.circle,
          color: getColor(),
          size: 35,
        ),
      ),
    );
  }
}
