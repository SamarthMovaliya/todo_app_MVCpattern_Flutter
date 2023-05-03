import 'package:flutter/material.dart';
import 'package:todo_app_flutter/models/todo_class_converter.dart';

import '../models/resources.dart';

class TodoHelper {
  TodoHelper._();

  static final TodoHelper todoHelper = TodoHelper._();

  addToTodoList({required Map data}) {
    TodoObject todoObject = TodoObject.fromMap(data: data);
    todos.add(todoObject);
  }
}
