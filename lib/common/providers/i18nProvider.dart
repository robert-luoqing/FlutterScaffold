import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SPI18NProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Locale _currentLocale = AppLocalizations.supportedLocales[0];
  SPI18NProvider();

  changeLocale(Locale locale) {
    this._currentLocale = locale;
    notifyListeners();
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

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}

class SPI18N {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}
