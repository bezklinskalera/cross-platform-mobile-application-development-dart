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
      home: FuelCalculator(),
    );
  }
}

class FuelCalculator extends StatefulWidget {
  const FuelCalculator({super.key});

  @override
  State<FuelCalculator> createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  final hController = TextEditingController(text: "4.2");
  final cController = TextEditingController(text: "62.1");
  final sController = TextEditingController(text: "3.3");
  final oController = TextEditingController(text: "6.4");
  final wController = TextEditingController(text: "7");
  final aController = TextEditingController(text: "15.8");

  double krs = 0;
  double krg = 0;
  double nRob = 0;
  double nSyha = 0;
  double nGor = 0;

  void calculate() {
    double h = double.parse(hController.text);
    double c = double.parse(cController.text);
    double s = double.parse(sController.text);
    double o = double.parse(oController.text);
    double w = double.parse(wController.text);
    double a = double.parse(aController.text);

    double Krs = 100 / (100 - w);
    double Krg = 100 / (100 - w - a);

    double NRob =
        (339 * c + 1030 * h - 108.8 * (o - s) - 25 * w) / 1000;

    double NSyha = ((NRob + 0.025 * w) * 100) / (100 - w);
    double NGor = ((NRob + 0.025 * w) * 100) / (100 - w - a);

    setState(() {
      krs = Krs;
      krg = Krg;
      nRob = NRob;
      nSyha = NSyha;
      nGor = NGor;
    });
  }

  Widget buildInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Калькулятор палива")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildInput("H, %", hController),
            const SizedBox(height: 10),
            buildInput("C, %", cController),
            const SizedBox(height: 10),
            buildInput("S, %", sController),
            const SizedBox(height: 10),
            buildInput("O, %", oController),
            const SizedBox(height: 10),
            buildInput("W, %", wController),
            const SizedBox(height: 10),
            buildInput("A, %", aController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: const Text("Обчислити"),
            ),
            const SizedBox(height: 20),
            Text("Krs: ${krs.toStringAsFixed(2)}"),
            Text("Krg: ${krg.toStringAsFixed(2)}"),
            Text("Нижча теплота (робоча): ${nRob.toStringAsFixed(2)}"),
            Text("Нижча теплота (суха): ${nSyha.toStringAsFixed(2)}"),
            Text("Нижча теплота (горюча): ${nGor.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
