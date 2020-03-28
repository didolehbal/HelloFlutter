import 'package:flutter/foundation.dart';

class ScoreModel extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void increment() {
    _score++;
    notifyListeners();
  }

  /// Removes all items from the cart.
  void reset() {
    _score = 0;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
