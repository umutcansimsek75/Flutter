import 'package:flutter/material.dart';
import 'screens/AnaEkran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrtalaMatik-943 Umut Can Şimşek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const OrtalaMatik()
    );
  }              
}
