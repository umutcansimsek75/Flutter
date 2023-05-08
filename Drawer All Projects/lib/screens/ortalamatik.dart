import 'package:flutter/material.dart';
import 'package:myapp/models/Lesson.dart';
import 'package:myapp/utils/drawer.dart';

class Ortalamatik extends StatefulWidget {
  const Ortalamatik({Key? key}) : super(key: key);

  @override
  State<Ortalamatik> createState() => _OrtalamatikState();
}

TextEditingController _dersAdi = TextEditingController();
TextEditingController _dersNotu = TextEditingController();
String _credit = "1";
var items = [
  '1',
  '2',
  '3',
  '4',
  '5',
];

class _OrtalamatikState extends State<Ortalamatik> {
  double ortalama = 0.0;
  double dersOrtalamasi = 0;
  double tumDerslerinOrtalamasi = 0;
  int toplamKredi = 0;
  List<Lesson> lessons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text(
          "OrtalaMatik-943 Umut Can Şimşek",
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amberAccent[800],
            child: Column(
              children: [
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _dersAdi,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Ders Adı",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 22),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 17, bottom: 17, right: 20),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              value: items.first,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("$value Kredi"),
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                _credit = selectedValue!;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFormField(
                              controller: _dersNotu,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Ders Notu",
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 22),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 20, top: 17, bottom: 17, right: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 33),
                Container(
                  height: 3,
                  color: Colors.red[200],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Ortalama : $ortalama",
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  color: Colors.red[200],
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    setState(() {
                      var item = lessons.firstWhere(
                          (element) => element.id == lessons[index].id);
                      lessons.remove(item);
                      ortalamaHesapla();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange[100],
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 25, top: 10, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 3),
                            Text(
                              lessons[index].name,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(height: 2, color: Colors.red),
                            const SizedBox(height: 3),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Kredi:",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(lessons[index].credit.toString(),
                                          style: const TextStyle(
                                              fontSize: 25, color: Colors.red)),
                                    ],
                                  ),
                                  const SizedBox(width: 35),
                                  Row(
                                    children: [
                                      const Text(
                                        "Notu:",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        lessons[index].note.toString(),
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[200],
        onPressed: () {
          if (_dersAdi.text == "") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("HATA!!"),
                content: const Text("Lütfen ders adı giriniz."),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          } else if (_dersNotu.text == "") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("HATA!!"),
                content: const Text("Lütfen ders notu giriniz."),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          } else {
            setState(() {
              addLesson();
              ortalamaHesapla();
              _dersAdi.clear();
              _dersNotu.clear();
            });
          }
          print(lessons);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
  void ortalamaHesapla() {
    setState(() {
      if (lessons.isNotEmpty) {
        for (var item in lessons) {
          dersOrtalamasi = item.note * item.credit;
          tumDerslerinOrtalamasi = tumDerslerinOrtalamasi + dersOrtalamasi;
          toplamKredi = toplamKredi + item.credit;
        }
        ortalama = tumDerslerinOrtalamasi / toplamKredi;
      } else {
        ortalama = 0;
      }
    });
  }

  void addLesson() {
    setState(() {
      lessons.add(Lesson(
          id: lessons.isNotEmpty ? lessons.last.id + 1 : 1,
          name: _dersAdi.text,
          credit: int.parse(_credit),
          note: double.parse(_dersNotu.text)));
    });
  }

}
