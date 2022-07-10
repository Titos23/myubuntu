import 'package:flutter/painting.dart';

class PassFields {
  
  static final List<String> values = [id, name, date];
  static final String id = 'id';
  static final String name = 'name';
  static final String date = 'date';
 // static final String code = 'code';
}
class PassItem {
  final String id;
  final String name;
  final DateTime date;
  // String code;
  bool isComplete;

  PassItem({
    required this.id,
    required this.name,
    required this.date,
    //required this.code,
    this.isComplete = false,
  });

  factory PassItem.fromMap(Map<String, dynamic> json) => PassItem(
    id: json[PassFields.id] as String,
    name: json[PassFields.name] as String,
    date: DateTime.parse(json[PassFields.date] as String),
    //code: json[PassFields.code] as String,
  );

  Map<String, dynamic> toMap() {
    return {
      
      PassFields.id:id,
      PassFields.name: name,
      PassFields.date: date.toIso8601String(),
    //  PassFields.code: code, 
    } ;
  }

  PassItem copyWith({
    String? id,
    String? name,
    Color? color,
    DateTime? date,
   // String? code,
    bool? isComplete,
  }) {
    return PassItem(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
    //  code: code ?? this.code,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
