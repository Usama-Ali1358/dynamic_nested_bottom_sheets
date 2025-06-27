import 'package:flutter/material.dart';

typedef SheetStackChanged = void Function(List<BuildContext>);

class SheetStackController extends ChangeNotifier {
  final List<BuildContext> _contexts = [];

  List<BuildContext> get contexts => List.unmodifiable(_contexts);

  void push(BuildContext context) {
    _contexts.add(context);
    notifyListeners();
  }

  void pop() {
    if (_contexts.isNotEmpty) {
      _contexts.removeLast();
      notifyListeners();
    }
  }

  void closeAll() {
    while (_contexts.isNotEmpty) {
      Navigator.of(_contexts.last).maybePop();
    }
    notifyListeners();
  }

  bool get hasSheets => _contexts.isNotEmpty;
}
