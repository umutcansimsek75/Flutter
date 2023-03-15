import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class Nalan extends StatefulWidget {
  const Nalan({super.key});

  @override
  State<Nalan> createState() => _NalanState();
}

class _NalanState extends State<Nalan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text("1213-Berat Çoban"),
          centerTitle: true,
          actions: const [
            Icon(Icons.settings),
            SizedBox(
              width: 5,
            )
          ],
        ),
        body: Container(
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("N", Colors.cyan[900]!),
                    box("A", Colors.cyan[800]!),
                    box("L", Colors.cyan[700]!),
                    box("A", Colors.cyan[600]!),
                    box("N", Colors.cyan[500]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.cyan[800]!),
                    box("A", Colors.cyan[800]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("L", Colors.cyan[700]!),
                    box("L", Colors.cyan[700]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.cyan[600]!),
                    box("A", Colors.cyan[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("N", Colors.cyan[900]!),
                    box("A", Colors.cyan[800]!),
                    box("L", Colors.cyan[700]!),
                    box("A", Colors.cyan[600]!),
                    box("N", Colors.cyan[500]!),
                  ],
                ),
              ],
            )));
  }
}

Widget box(String word, Color color) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          word,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    ),
    color: color,
    width: 80,
    height: 120,
  );
}
