import 'dart:async';

import 'package:connectivity/connectivity.dart';

class NetUtil {
  late StreamSubscription _subscription;
  ConnectivityResult? _status;
  static NetUtil? _cache;
  factory NetUtil() {
    _cache ??= NetUtil._internal();
    return _cache!;
  }

  NetUtil._internal() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _status = result;
    });
  }

  Future<bool> isOnline() async {
    _status ??= await Connectivity().checkConnectivity();
    return _status == ConnectivityResult.none ? false : true;
  }

  void close() {
    _subscription.cancel();
  }

  void dispose() {
    _subscription.cancel();
  }
}
