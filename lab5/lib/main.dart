import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Практична робота №5',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
      ),
      home: const Lab5Page(),
    );
  }
}

class Lab5Page extends StatefulWidget {
  const Lab5Page({super.key});

  @override
  State<Lab5Page> createState() => _Lab5PageState();
}

class _Lab5PageState extends State<Lab5Page> {

  double chVidEl110 = 0.1;
  double trVidEl110 = 30;

  double chVidPl110 = 0.07;
  double trVidPl110 = 10;

  double chVidT110 = 0.015;
  double trVidT110 = 100;

  double chVidVV10 = 0.02;
  double trVidVV10 = 15;

  double chVidPr10 = 0.18;
  double trVidPr10 = 2;

  double chVidSek = 0.02;

  double zbutkiAv = 23.6;
  double zbutkiPl = 17.6;

  double chVid2 = 0.01;
  double trVid2 = 0.045;
  double serChas2 = 0.004;

  double? chastotaOdnok;
  double? tryvOdnok;
  double? kAvaRes;
  double? kPlanRes;
  double? chDvaRes;
  double? chDvaSekRes;

  double? matAvRes;
  double? matPlRes;
  double? matZbRes;


  double chastotaVidOdnok() {
    return chVidEl110 +
        chVidPl110 +
        chVidT110 +
        chVidVV10 +
        chVidPr10;
  }

  double tryvVidOdnok() {
    return (chVidEl110 * trVidEl110 +
        chVidPl110 * trVidPl110 +
        chVidT110 * trVidT110 +
        chVidVV10 * trVidVV10 +
        chVidPr10 * trVidPr10) /
        chastotaVidOdnok();
  }

  double kAva() {
    return (chastotaVidOdnok() * tryvVidOdnok()) / 8760;
  }

  double kPlan() {
    return 1.2 * (43 / 8760);
  }

  double chDvaKola() {
    return 2 * chastotaVidOdnok() * (kAva() + kPlan());
  }

  double chDvaKolaSek() {
    return chDvaKola() + chVidSek;
  }

  double matAv() {
    return chVid2 * trVid2 * 5120 * 6451;
  }

  double matPl() {
    return serChas2 * 5120 * 6451;
  }

  double matZb() {
    return zbutkiAv * matAv() + zbutkiPl * matPl();
  }

  void calculate() {
    setState(() {
      chastotaOdnok = chastotaVidOdnok();
      tryvOdnok = tryvVidOdnok();
      kAvaRes = kAva();
      kPlanRes = kPlan();
      chDvaRes = chDvaKola();
      chDvaSekRes = chDvaKolaSek();

      matAvRes = matAv();
      matPlRes = matPl();
      matZbRes = matZb();
    });
  }

  Widget resultTile(String title, String? value) {
    return Card(
      color: Colors.orange.shade100,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(value ?? "-"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Практична робота №5. Надійність електропостачальних систем'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Порівняння одноколової та двоколової систем",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            const SizedBox(height: 20),

            resultTile("Частота відмов одноколової системи:",
                chastotaOdnok?.toStringAsFixed(3)),
            resultTile("Середня тривалість відновлення:",
                tryvOdnok?.toStringAsFixed(1)),
            resultTile(
                "Коефіцієнт аварійного простою:",
                kAvaRes?.toStringAsFixed(5)),
            resultTile(
                "Коефіцієнт планового простою:",
                kPlanRes?.toStringAsFixed(5)),
            resultTile(
                "Частота відмов двох кіл:",
                chDvaRes?.toStringAsFixed(5)),
            resultTile(
                "Частота відмов двоколової системи:",
                chDvaSekRes?.toStringAsFixed(4)),

            const SizedBox(height: 30),

            const Text(
              "Збитки від перерв електропостачання",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            const SizedBox(height: 20),

            resultTile("Математичне сподівання аварійного недовідпуску:",
                matAvRes?.toStringAsFixed(0)),
            resultTile("Математичне сподівання планового недовідпуску:",
                matPlRes?.toStringAsFixed(0)),
            resultTile("Математичне сподівання збитків:",
                matZbRes?.toStringAsFixed(0)),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: calculate,
              child: const Text(
                "Обчислимо",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
