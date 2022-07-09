import 'package:flutter/painting.dart';

class PassFields {
  
  static final List<String> values = [id, name, date];
  static final String id = 'id';
  static final String name = 'name';
  static final String date = 'date';
}
class PassItem {
  final String id;
  final String name;
  final DateTime date;
  bool isComplete;

  PassItem({
    required this.id,
    required this.name,
    required this.date,
    this.isComplete = false,
  });

  factory PassItem.fromMap(Map<String, dynamic> json) => PassItem(
    id: json[PassFields.id] as String,
    name: json[PassFields.name] as String,
    date: DateTime.parse(json[PassFields.date] as String),
  );

  Map<String, dynamic> toMap() {
    return {
      
      PassFields.id:id,
      PassFields.name: name,
      PassFields.date: date.toIso8601String(), 
    } ;
  }

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
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
