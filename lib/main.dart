import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hesap Makinesi",
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basit Hesap Makinesi'),
      ),
      body: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  num sayi1 = 0, sayi2 = 0, sonuc = 0;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  sayiTopla() {
    setState(() {
      sayi1 = num.parse(t1.text);
      sayi2 = num.parse(t2.text);
      sonuc = sayi1 + sayi2;
    });
  }

  sayiCikar() {
    setState(() {
      sayi1 = num.parse(t1.text);
      sayi2 = num.parse(t2.text);
      sonuc = sayi1 - sayi2;
    });
  }

  sayiCarp() {
    setState(() {
      sayi1 = num.parse(t1.text);
      sayi2 = num.parse(t2.text);
      sonuc = sayi1 * sayi2;
    });
  }

  sayiBol() {
    setState(() {
      sayi1 = num.parse(t1.text);
      sayi2 = num.parse(t2.text);
      sonuc = sayi1 / sayi2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        50,
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("$sonuc"),
            TextField(
              controller: t1,
            ),
            TextField(
              controller: t2,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
                child: ElevatedButton(
                  onPressed: sayiTopla,
                  child: Text("Topla"),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
              child: ElevatedButton(
                onPressed: sayiCikar,
                child: Text("Çıkar"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
              child: ElevatedButton(
                onPressed: sayiCarp,
                child: Text("Çarp"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
              child: ElevatedButton(
                onPressed: sayiBol,
                child: Text("Böl"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
