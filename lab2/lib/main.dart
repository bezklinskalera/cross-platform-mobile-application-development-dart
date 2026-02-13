import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lab2Full(),
    );
  }
}

class Lab2Full extends StatefulWidget {
  const Lab2Full({super.key});

  @override
  State<Lab2Full> createState() => _Lab2FullState();
}

class _Lab2FullState extends State<Lab2Full> {

  final vugController = TextEditingController(text: "858613.05");
  final mazutController = TextEditingController(text: "88993.41");
  final gazController = TextEditingController(text: "104435.26");

  // Константи
  final double teplotaVug = 20.47;
  final double teplotaMazut = 40.40;
  final double teplotaGaz = 33.08;

  final double zolaVug = 25.20;
  final double zolaMazut = 0.15;

  final double gorRechVug = 1.5;
  final double efect = 0.985;

  double emVug = 0;
  double valVug = 0;
  double emMazut = 0;
  double valMazut = 0;
  double valGaz = 0;

  void calculate() {
    double vug = double.parse(vugController.text);
    double mazut = double.parse(mazutController.text);
    double gaz = double.parse(gazController.text);

    double emV =
        (1000000 / teplotaVug) *
            0.8 *
            (zolaVug / (100 - gorRechVug)) *
            (1 - efect);

    double valV =
        0.000001 * emV * teplotaVug * vug;

    double emM =
        (1000000 / teplotaMazut) *
            1 *
            (zolaMazut / 100) *
            (1 - efect);

    double valM =
        0.000001 * emM * teplotaMazut * mazut;

    double valG =
        0.000001 *
            0 *
            teplotaGaz *
            gaz;

    setState(() {
      emVug = emV;
      valVug = valV;
      emMazut = emM;
      valMazut = valM;
      valGaz = valG;
    });
  }

  Widget tableRow(String a, String b, String c, String d, String e, String f, String g, String h) {
    return TableRowInkWell(
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            cell(a), cell(b), cell(c), cell(d),
            cell(e), cell(f), cell(g), cell(h),
          ])
        ],
      ),
    );
  }

  Widget cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget resultText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Практична робота №2")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [

            const Text(
              "Введіть обсяг палива:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: vugController,
              decoration: const InputDecoration(
                  labelText: "Вугілля, т",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: mazutController,
              decoration: const InputDecoration(
                  labelText: "Мазут, т",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: gazController,
              decoration: const InputDecoration(
                  labelText: "Газ, м³",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: calculate,
              child: const Text("Обчислимо"),
            ),

            const Divider(height: 30),

            resultText("Валовий викид вугілля (т): ${valVug.toStringAsFixed(2)}"),
            resultText("Показник емісії вугілля (г/Дж): ${emVug.toStringAsFixed(2)}"),
            resultText("Валовий викид мазуту (т): ${valMazut.toStringAsFixed(2)}"),
            resultText("Показник емісії мазуту (г/Дж): ${emMazut.toStringAsFixed(2)}"),
            resultText("Валовий викид газу (т): ${valGaz.toStringAsFixed(2)}"),
            resultText("Показник емісії газу (г/Дж): 0"),

            const Divider(height: 30),

            const Text(
              "Склад робочої маси вугілля",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  cell("H"), cell("C"), cell("S"), cell("N"),
                  cell("O"), cell("W"), cell("A"), cell("V"),
                ]),
                TableRow(children: [
                  cell("3.50"), cell("52.49"), cell("2.85"), cell("0.97"),
                  cell("4.99"), cell("10.00"), cell("25.20"), cell("25.92"),
                ])
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Склад мазуту",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  cell("H"), cell("C"), cell("S"), cell("N"),
                  cell("O"), cell("W"), cell("A"), cell("V"),
                ]),
                TableRow(children: [
                  cell("11.20"), cell("85.50"), cell("2.50"), cell("0.80"),
                  cell("0.80"), cell("2.00"), cell("0.15"), cell("333.3"),
                ])
              ],
            ),

          ],
        ),
      ),
    );
  }
}
