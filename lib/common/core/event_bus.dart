//订阅者回调签名
import 'event_bus_type.dart';

typedef SPEventCallback = void Function(dynamic arg);

class SPEventBus {
  //私有构造函数
  SPEventBus._internal();

  //保存单例
  static final SPEventBus _singleton = SPEventBus._internal();

  //工厂构造函数
  factory SPEventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  final _emap = <SPEventBusType, List<SPEventCallback>?>{};

  //添加订阅者
  void on(SPEventBusType eventType, SPEventCallback f) {
    _emap[eventType] ??= <SPEventCallback>[];
    _emap[eventType]!.add(f);
  }

  //移除订阅者
  void off(SPEventBusType eventType, [SPEventCallback? f]) {
    var list = _emap[eventType];
    if (list == null) return;
    if (f == null) {
      _emap[eventType] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(SPEventBusType eventType, [arg]) {
    var list = _emap[eventType];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
