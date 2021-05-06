import 'dart:async';

import 'package:connectivity/connectivity.dart';

class NetUtil {
  StreamSubscription? _subscription;
  ConnectivityResult? _status;
  static NetUtil? _cache;
  factory NetUtil() {
    if (_cache == null) {
      _cache = NetUtil._internal();
    }
    return _cache!;
  }

  NetUtil._internal() {
    this._subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _status = result;
    });
  }

  Future<bool> isOnline() async {
    if (_status == null) {
      _status = await Connectivity().checkConnectivity();
    }

    return _status == ConnectivityResult.none ? false : true;
  }

  void close() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}