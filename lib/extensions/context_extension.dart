import 'package:flutter/material.dart';
import 'package:toyotamobile/Service/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}
