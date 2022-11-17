import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String futureStatus = 'incomplete';

  @override
  void initState() {
    super.initState();

    // This Future will never complete ):
    _getThingOverFlakyNetwork()
        .catchError((error, stackTrace) => _getThingOverReliableNetwork())
        .then((value) {
          setState(() {
            futureStatus = 'future completed!';
          });
        });
  }

  Future<String> _getThingOverReliableNetwork() {
    debugPrint('_getThingOverReliableNetwork');
    return SynchronousFuture<String>('_getThingOverReliableNetwork');
  }

  Future<String> _getThingOverFlakyNetwork() {
    debugPrint('_getThingOverFlakyNetwork');
    return SynchronousFuture<String>('_getThingOverFlakyNetwork');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget title :)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('futureStatus: $futureStatus'),
          ],
        ),
      ),
    );
  }
}
