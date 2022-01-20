import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

typedef ReceiveCallback = void Function(dynamic data);

class SPWebSocket {
  IOWebSocketChannel? _channel;
  final ReceiveCallback? onReceive;
  final ReceiveCallback? onDisconnect;
  final ReceiveCallback? onError;
  SPWebSocket(String url, {this.onReceive, this.onDisconnect, this.onError});

  void connect(String url) {
    if (_channel != null) {
      _channel!.sink.close();
    }

    _channel = IOWebSocketChannel.connect(url);
    _channel!.stream.listen((message) {
      if (onReceive != null) {
        onReceive!(message);
      }
    }, onDone: () {
      if (onDisconnect != null) {
        onDisconnect!("disconnect");
      }
    }, onError: (error) {
      if (onError != null) {
        onError!(error);
      }
    });
  }

  void send(String msg) {
    if (_channel == null) {
      throw "Error, the socket didn't open";
    } else {
      _channel!.sink.add(msg);
    }
  }

  void close() {
    if (_channel != null) {
      _channel!.sink.close(status.goingAway);
    }
  }
}
