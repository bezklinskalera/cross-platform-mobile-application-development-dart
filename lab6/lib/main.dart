import 'dart:math';
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
      title: 'Практична робота №6',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF3E5F5),
      ),
      home: const Lab6Page(),
    );
  }
}

class Lab6Page extends StatefulWidget {
  const Lab6Page({super.key});

  @override
  State<Lab6Page> createState() => _Lab6PageState();
}

class _Lab6PageState extends State<Lab6Page> {
  // ===== Вхідні дані =====
  double serDPot = 5;
  double serKvadrVid = 1;
  double serKvadrVidZmen = 0.25;
  double vartist = 7;

  // ===== Результати =====
  double? chastkaEn;
  double? w1Res;
  double? prub1Res;
  double? w2Res;
  double? sh1Res;
  double? chastkaEn2;
  double? w3Res;
  double? prub2Res;
  double? w4Res;
  double? sh2Res;
  double? gPrubRes;

  // ===== Формули =====

  double erf(double x) {
    final a1 = 0.254829592;
    final a2 = -0.284496736;
    final a3 = 1.421413741;
    final a4 = -1.453152027;
    final a5 = 1.061405429;
    final p = 0.3275911;

    final sign = x >= 0 ? 1.0 : -1.0;
    x = x.abs();
    final t = 1.0 / (1.0 + p * x);
    final y = 1 -
        ((((a5 * t + a4) * t + a3) * t + a2) * t + a1) *
            t *
            exp(-x * x);
    return sign * y * 100; // множимо на 100, як у JS
  }

  double chastkaEnergi(double mean, double stddev) {
    const lowerBound = 4.75;
    const upperBound = 5.25;
    return 0.5 *
        (erf((upperBound - mean) / (sqrt(2) * stddev)) -
            erf((lowerBound - mean) / (sqrt(2) * stddev)));
  }

  double w1(double mean, double stddev) {
    return mean * 24 * chastkaEnergi(mean, stddev) * 0.01;
  }

  double w2(double mean, double stddev) {
    return mean * 24 * (100 - chastkaEnergi(mean, stddev)) * 0.01;
  }

  void calculate() {
    setState(() {
      // Частка енергії без небалансів
      chastkaEn = chastkaEnergi(serDPot, serKvadrVid).roundToDouble();
      w1Res = w1(serDPot, serKvadrVid).roundToDouble();
      w2Res = w2(serDPot, serKvadrVid).roundToDouble();
      prub1Res = w1Res! * vartist;
      sh1Res = w2Res! * vartist;

      chastkaEn2 = chastkaEnergi(serDPot, serKvadrVidZmen).roundToDouble();
      w3Res = w1(serDPot, serKvadrVidZmen);
      w4Res = w2(serDPot, serKvadrVidZmen);
      prub2Res = (w3Res! * vartist).toDouble();
      sh2Res = (w4Res! * vartist).toDouble();
      gPrubRes = (prub2Res! - sh2Res!).toDouble();
    });
  }

  Widget resultTile(String title, dynamic value) {
    return Card(
      color: Colors.purple.shade100,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
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
            Text(value?.toString() ?? '-'),
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
            'Практична робота №6. Розрахунок прибутку від сонячних електростанцій'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            resultTile(
                "Частка енергії без небалансів (%)", chastkaEn),
            resultTile("W1 (МВт*год)", w1Res),
            resultTile("Прибуток1 (тис. грн)", prub1Res),
            resultTile("W2 (МВт*год)", w2Res),
            resultTile("Штраф1 (тис. грн)", sh1Res),
            resultTile(
                "Частка енергії після вдосконалення (%)", chastkaEn2),
            resultTile("W3 (МВт*год)", w3Res?.toStringAsFixed(1)),
            resultTile("Прибуток2 (тис. грн)", prub2Res?.toStringAsFixed(1)),
            resultTile("W4 (МВт*год)", w4Res?.toStringAsFixed(1)),
            resultTile("Штраф2 (тис. грн)", sh2Res?.toStringAsFixed(1)),
            resultTile("Головний прибуток (тис. грн)", gPrubRes?.toStringAsFixed(1)),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: calculate,
              child: const Text(
                "Обчислимо",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
