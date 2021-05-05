import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:timecounter/app_controller.dart';
import 'package:timecounter/interval_input.dart';
import 'package:timecounter/interval_overview.dart';

late final appController = AppController();

void main() {
  runApp(
    MaterialApp(
      title: 'Time Counter',
      home: App(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: createMaterialColor(Color(0xFFAA4444)),
        accentColor: Color(0xFFAA4444),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntervalInput(),
          IntervalOverview(),
        ],
      ),
    );
  }
}
