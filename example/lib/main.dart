import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:myplugin/my_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await MyPlugin.instance.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
              children: [
              Text('Running on: $_platformVersion\n'),
          FutureBuilder<int>(
              initialData: 0,
              future: MyPlugin.instance.sum(1, 2),
              builder: (context, data) {
                return Text('${data.data}');
              }),
          GestureDetector(
            onTap: () {
              MyPlugin.instance.startCounter();
            },
            child: Container(
              height: 50,
              width: 100,
              color: Colors.redAccent,
              alignment: Alignment.center,
              child: const Text('startCounter'),
            ),
          ),
          StreamBuilder<int>(
              initialData: 0,
              stream: MyPlugin.instance.eventFor(),
              builder: (context, data) {
                return Text('${data.data}');
              }),
          ],
        ),
      ),
    ),);
  }
}
