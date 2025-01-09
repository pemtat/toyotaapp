import 'package:flutter/material.dart';
import 'package:toyotamobile/Service/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);
}
