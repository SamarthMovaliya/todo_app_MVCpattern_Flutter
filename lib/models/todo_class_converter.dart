import 'package:flutter/material.dart';

class TodoObject {
  String time;
  String todo;

  TodoObject({
    required this.time,
    required this.todo,
  });

  factory TodoObject.fromMap({required Map data}) {
    return TodoObject(time: data['time'], todo: data['todo']);
  }
}
