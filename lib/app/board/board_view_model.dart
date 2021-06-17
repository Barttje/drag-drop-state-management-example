import 'package:drag_drop_state_management/app/model/checker.dart';
import 'package:drag_drop_state_management/app/model/coordinate.dart';
import 'package:drag_drop_state_management/app/model/player_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _currentPlayer = StateProvider((ref) => PlayerType.BLACK);
final currentPlayer = Provider((ref) => ref.watch(_currentPlayer).state);

final checkers = StateNotifierProvider<CheckerNotifier, List<Checker>>(
    (ref) => CheckerNotifier(ref.watch));

class CheckerNotifier extends StateNotifier<List<Checker>> {
  var watch;
  CheckerNotifier(this.watch)
      : super([
          Checker(1, PlayerType.BLACK, new Coordinate(0, 0)),
          Checker(2, PlayerType.WHITE, new Coordinate(0, 1))
        ]);

  void add(Checker checker) {
    state = [...state, checker];
  }

  void startDrag(Checker selectedChecker) {
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: true)
        else
          checker,
    ];
  }

  void cancelDrag(Checker selectedChecker) {
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: false)
        else
          checker,
    ];
  }

  void finishDrag(Checker selectedChecker, Coordinate coordinate) {
    state = [
      for (final checker in state)
        if (checker == selectedChecker)
          checker.copyWith(isDragging: false, coordinate: coordinate)
        else
          checker
    ];
    watch(_currentPlayer.notifier).state =
        watch(_currentPlayer.notifier).state == PlayerType.BLACK
            ? PlayerType.WHITE
            : PlayerType.BLACK;
  }
}
