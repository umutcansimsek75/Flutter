import 'package:flutter/material.dart';
import 'package:myapp/utils/drawer.dart';


class Nalan extends StatefulWidget {
  const Nalan({super.key});

  @override
  State<Nalan> createState() => _NalanState();
}

class _NalanState extends State<Nalan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text("943-Umut Can Şimşek"),
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
                    box("N", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                    box("L", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                    box("N", Colors.orange[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("L", Colors.orange[600]!),
                    box("L", Colors.orange[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("A", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    box("N", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                    box("L", Colors.orange[600]!),
                    box("A", Colors.orange[600]!),
                    box("N", Colors.orange[600]!),
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