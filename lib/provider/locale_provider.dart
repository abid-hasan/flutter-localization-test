import 'package:flutter/material.dart';
import 'package:multiple_localization_test/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  Locale? _local;

  Locale? get locale => _local;

  void setLocale(Locale? locale) {
    if (!L10N.all.contains(locale)) return;

    _local = locale;
    notifyListeners();
  }

  void clearLocale() {
    _local = null;
    notifyListeners();
  }
}
