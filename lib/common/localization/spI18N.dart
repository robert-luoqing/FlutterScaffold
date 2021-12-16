import 'package:FlutterScaffold/common/core/eventBus.dart';
import 'package:FlutterScaffold/common/core/eventBusType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SPI18N {
  static SPI18N _instance = SPI18N._();
  Locale _currentLocale = AppLocalizations.supportedLocales[0];

  factory SPI18N() {
    return _instance;
  }
  SPI18N._();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  get currentLocale {
    return _currentLocale;
  }

  get supportedLocales {
    return AppLocalizations.supportedLocales;
  }

  get delegate {
    return AppLocalizations.delegate;
  }

  changeLocale(Locale locale) {
    this._currentLocale = locale;
    SPEventBus().emit(SPEventBusType.LocaleChanged);
  }
}
