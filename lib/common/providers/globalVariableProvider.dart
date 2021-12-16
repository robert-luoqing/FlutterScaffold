import 'package:flutter/foundation.dart';

class SPGlobalVariableProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _needShowPrice = false;
  SPGlobalVariableProvider();

  bool get needShowPrice => _needShowPrice;

  void updateNeedShowPrice(bool showPrice) {
    this._needShowPrice = showPrice;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}
