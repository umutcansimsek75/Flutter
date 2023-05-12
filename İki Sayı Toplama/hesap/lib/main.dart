import 'package:flutter/material.dart';

import 'SCREANS/counter.dart';
import 'SCREANS/nalan.dart';
void main(List<String> args) {
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projem",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Toplama(),
    );
  }
  }