import 'package:pigeon/pigeon.dart';
///flutter pub run pigeon --input lib/my_api.dart
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/my_api.g.dart',
  javaOut: 'android/src/main/java/com/example/myplugin/MyAPIGen.java',
  javaOptions: JavaOptions(package: 'com.example.myplugin'),
  objcHeaderOut: 'ios/Classes/MyAPIGen.h',
  objcSourceOut: 'ios/Classes/MyAPIGen.m',
))
@HostApi()
abstract class MyAPI {
  @async
  int sum(int a, int b);

}
