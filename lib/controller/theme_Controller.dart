import 'package:flutter/material.dart';

import '../models/theme_modal.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
