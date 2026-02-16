import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лаба 3 - Калькулятор ЕП',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final pShlifController = TextEditingController(text: '21');
  final kvPoliController = TextEditingController(text: '0.22');
  final tgZhyrController = TextEditingController(text: '1.56');

  double kvShlif = 0.15;
  double kvSver = 0.12;
  double kvFyg = 0.15;
  double kvZhyr = 0.3;
  double kvPres = 0.5;
  double kvPoli = 0.22;
  double kvFres = 0.2;
  double kvVent = 0.65;

  int pNomShlif = 21;
  int pNomSver = 14;
  int pNomFyg = 42;
  int pNomZhyr = 36;
  int pNomPres = 20;
  int pNomPoli = 40;
  int pNomFres = 32;
  int pNomVent = 20;

  double tgShlif = 1.33;
  double tgSver = 1;
  double tgFyg = 1.33;
  double tgZhyr = 1.56;
  double tgPres = 0.75;
  double tgPoli = 1;
  double tgFres = 1;
  double tgVent = 0.75;

  int nShlif = 4;
  int nSver = 2;
  int nFyg = 4;
  int nZhyr = 1;
  int nPres = 1;
  int nPoli = 1;
  int nFres = 2;
  int nVent = 1;

  double calcPn(int n, int p) => n * p.toDouble();
  double calcPnKv(int n, int p, double kv) => n * p * kv;
  double calcPnKvTg(int n, int p, double kv, double tg) => n * p * kv * tg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Практична робота 3')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Введіть дані:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pShlifController,
                    decoration: const InputDecoration(
                      labelText: 'Номінальна потужність Шліфувальний верстат (кВт)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: kvPoliController,
                    decoration: const InputDecoration(
                      labelText: 'Коефіцієнт використання Полірувальний верстат',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: tgZhyrController,
                    decoration: const InputDecoration(
                      labelText: 'Коефіцієнт реактивної потужності Циркулярна пила',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pNomShlif = int.tryParse(pShlifController.text) ?? 21;
                  kvPoli = double.tryParse(kvPoliController.text) ?? 0.22;
                  tgZhyr = double.tryParse(tgZhyrController.text) ?? 1.56;
                });
              },
              child: const Text('Обчислити'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.pink[100]),
                  columns: const [
                    DataColumn(label: Text('№')),
                    DataColumn(label: Text('ЕП')),
                    DataColumn(label: Text('n')),
                    DataColumn(label: Text('Pн')),
                    DataColumn(label: Text('Кв')),
                    DataColumn(label: Text('tgφ')),
                    DataColumn(label: Text('Pn')),
                    DataColumn(label: Text('Pn*Kv')),
                    DataColumn(label: Text('Pn*Kv*tgφ')),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('1')),
                      const DataCell(Text('Шліфувальний верстат')),
                      DataCell(Text('$nShlif')),
                      DataCell(Text('$pNomShlif')),
                      DataCell(Text('$kvShlif')),
                      DataCell(Text('$tgShlif')),
                      DataCell(Text('${calcPn(nShlif, pNomShlif).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKv(nShlif, pNomShlif, kvShlif).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKvTg(nShlif, pNomShlif, kvShlif, tgShlif).toStringAsFixed(1)}')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('2')),
                      const DataCell(Text('Полірувальний верстат')),
                      DataCell(Text('$nPoli')),
                      DataCell(Text('$pNomPoli')),
                      DataCell(Text('$kvPoli')),
                      DataCell(Text('$tgPoli')),
                      DataCell(Text('${calcPn(nPoli, pNomPoli).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKv(nPoli, pNomPoli, kvPoli).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKvTg(nPoli, pNomPoli, kvPoli, tgPoli).toStringAsFixed(1)}')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('3')),
                      const DataCell(Text('Циркулярна пила')),
                      DataCell(Text('$nZhyr')),
                      DataCell(Text('$pNomZhyr')),
                      DataCell(Text('$kvZhyr')),
                      DataCell(Text('$tgZhyr')),
                      DataCell(Text('${calcPn(nZhyr, pNomZhyr).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKv(nZhyr, pNomZhyr, kvZhyr).toStringAsFixed(1)}')),
                      DataCell(Text('${calcPnKvTg(nZhyr, pNomZhyr, kvZhyr, tgZhyr).toStringAsFixed(1)}')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
