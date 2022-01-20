import 'package:lingo_dragon/theme/base_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SPThemeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  BaseTheme _currentTheme = BaseTheme();
  SPThemeProvider();

  changeTheme(BaseTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  get currentTheme {
    return _currentTheme;
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}

class SPTheme extends InheritedWidget {
  final BaseTheme theme;
  const SPTheme({Key? key, required this.theme, required Widget child})
      : super(key: key, child: child);

  static BaseTheme of(BuildContext context) {
    var themeWidget = context.dependOnInheritedWidgetOfExactType<SPTheme>();
    return themeWidget!.theme;
  }

  @override
  bool updateShouldNotify(covariant SPTheme oldWidget) {
    return oldWidget.theme != theme;
  }
}
