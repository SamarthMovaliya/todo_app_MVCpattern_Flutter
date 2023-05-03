import 'package:flutter/material.dart';
import 'package:todo_app_flutter/models/todo_class_converter.dart';

String todo = '';
TextEditingController todoController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
List<TodoObject> todos = [];
