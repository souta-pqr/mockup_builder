import 'package:flutter/material.dart';

class EditorState extends ChangeNotifier {
  final List<DesignElement> elements = [];

  void addElement(DesignElement element) {
    elements.add(element);
    notifyListeners();
  }

  void updateElementPosition(int index, Offset position) {
    if (index < elements.length) {
      elements[index] = elements[index].copyWith(position: position);
      notifyListeners();
    }
  }
}

class DesignElement {
  final String type;
  final Offset position;
  final Size size;

  DesignElement({
    required this.type,
    required this.position,
    this.size = const Size(100, 50),
  });

  DesignElement copyWith({
    String? type,
    Offset? position,
    Size? size,
  }) {
    return DesignElement(
      type: type ?? this.type,
      position: position ?? this.position,
      size: size ?? this.size,
    );
  }
}