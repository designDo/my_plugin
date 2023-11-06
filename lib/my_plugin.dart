import 'package:flutter/services.dart';
import 'package:myplugin/my_api.g.dart';

class MyPlugin {
  static MyPlugin get instance => MyPlugin();

  final methodChannel = const MethodChannel('myplugin');

  final EventChannel eventChannel = const EventChannel('my_event_channel');

  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  void startCounter() async {
    await methodChannel.invokeMethod<bool>('startCounter');
  }

  Future<int> sum(int a, int b) async {
    return MyAPI().sum(a, b);
  }

  Stream<int> eventFor() {
    return eventChannel.receiveBroadcastStream().map((event) => event['num']);
  }
}
