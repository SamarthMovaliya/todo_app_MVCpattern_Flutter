import 'package:flutter/material.dart';
import 'package:todo_app_flutter/models/time_model.dart';

class TimeController extends ChangeNotifier {
  TimeModal timeModal = TimeModal(time: 9, timeNote: 'AM');

  increment() {
    if (timeModal.time == 7 && timeModal.timeNote == 'PM') {
      timeModal.time = 7;
      timeModal.timeNote = 'PM';
    } else if (timeModal.time < 12) {
      ++timeModal.time;
    } else {
      timeModal.time = 0;
      ++timeModal.time;
      timeModal.timeNote = 'PM';
    }
    notifyListeners();
  }
}
