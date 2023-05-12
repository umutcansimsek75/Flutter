import 'package:flutter/material.dart';
import 'package:myapp/models/dersler.dart';

class OrtalaMatik extends StatefulWidget {
  const OrtalaMatik({super.key});

  @override
  State<OrtalaMatik> createState() => _OrtalaMatikState();
}

List<String> items = ['1 Kredi', '2 Kredi', '3 Kredi', '4 Kredi'];

class _OrtalaMatikState extends State<OrtalaMatik> {
  List<Ders> dersler = [];
  String dersAdi = "";
  final dersController = TextEditingController();
  final notController = TextEditingController();

  String dropdownvalue = items.first;
  int _kredi = 0;
  double ortalama = 0;

  @override
  void krediDeger() {
    setState(() {
      if (dropdownvalue == items[0]) {
        _kredi = 1;
      }
      if (dropdownvalue == items[1]) {
        _kredi = 2;
      }
      if (dropdownvalue == items[2]) {
        _kredi = 3;
      }
      if (dropdownvalue == items[3]) {
        _kredi = 4;
      }
    });
  }

  void addLesson() {
    setState(() {
      dersler.add(Ders(
          id: dersler.isNotEmpty ? dersler.last.id + 1 : 1,
          title: dersController.text,
          kredi: _kredi,
          not: int.parse(notController.text)));
    });
  }

  void ortalamaHesapla() {
    setState(() {
      int dersOrtalamasi = 0;
      int courseAverages = 0;
      int toplamKredi = 0;
      if (dersler.isNotEmpty) {
        for (var item in dersler) {
          dersOrtalamasi = item.not * item.kredi;
          courseAverages = courseAverages + dersOrtalamasi;
          toplamKredi = toplamKredi + item.kredi;
        }
        ortalama = courseAverages / toplamKredi;
      }
      else{
        ortalama = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OrtalaMatik-943 Umut Can Şimşek"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            krediDeger();
            addLesson();
            ortalamaHesapla();
            dersController.clear();
            notController.clear();
          });
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: dersController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ders Adı",
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(width: 3, color: Colors.amber),
                        ),
                      ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: notController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ders Notu",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Ortalama : $ortalama",
                  style: const TextStyle(fontSize: 34,
                  color: Colors.red),
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                itemCount: dersler.length,
                itemBuilder: (BuildContext context, int index) {
                  Ders item = dersler[index];
                  return ListTile(
                    tileColor: Colors.yellow,
                    title: InkWell(
                      onLongPress: () {
                        setState(() {
                          dersler.remove(item);
                          ortalamaHesapla();
                        });
                      },
                      child: Text(
                        item.title,
                      ),
                    ),
                    subtitle: InkWell(
                      child: Text("Kredi: ${item.kredi}\tNotu :${item.not}"),
                      onLongPress: () {
                        setState(() {
                          dersler.remove(item);
                          ortalamaHesapla();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}