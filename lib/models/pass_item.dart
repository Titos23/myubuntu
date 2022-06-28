import 'package:flutter/painting.dart';

class PassItem {
  final String id;
  final String name;
  final Color color;
  final DateTime date;
  final bool isComplete;

  PassItem({
    required this.id,
    required this.name,
    required this.color,
    required this.date,
    this.isComplete = false,
  });

  PassItem copyWith({
    String? id,
    String? name,
    Color? color,
    DateTime? date,
    bool? isComplete,
  }) {
    return PassItem(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
