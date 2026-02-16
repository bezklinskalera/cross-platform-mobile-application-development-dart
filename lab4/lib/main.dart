import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практична робота №4',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Практична робота №4'),
        ),
        body: LabPage(),
      ),
    );
  }
}

class LabPage extends StatefulWidget {
  @override
  _LabPageState createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  // Вхідні дані
  double strymKZ = 2.5;
  double napryga = 10;
  double fictTimeKZ = 2.5;
  double potTP = 2000;
  double rozNav = 1300;
  double tm = 4000;
  double potKZ2 = 200;
  double napruga2 = 10.5;
  double sNomt2 = 6.3;
  double rSn3 = 10.65;
  double xSn3 = 24.02;
  double rSmin3 = 34.88;
  double xSmin3 = 65.68;
  double umax3 = 11.1;
  double uVn3 = 115;
  double ll3 = 12.37;
  double rl0 = 0.64;
  double xl0 = 0.363;

  // Результати
  double? rozStrymNormAv;
  double? rozStrymAv;
  double? ecoPerer;
  double? ss;
  double? opirXC;
  double? opirXT;
  double? sumaOpir;
  double? pochStrym;
  double? reaktOpir;
  double? xSh3Res;
  double? xShmin3Res;
  double? zSh3Res;
  double? zShmin3Res;
  double? iSh3Res;
  double? iSh23Res;
  double? iShmin3Res;
  double? iShmin23Res;
  double? kPrRes;

  void calculate() {
    setState(() {
      rozStrymNormAv = (rozNav / 2) / (sqrt(3) * napryga);
      rozStrymAv = 2 * rozStrymNormAv!;
      ecoPerer = rozStrymNormAv! / 1.4;
      ss = (strymKZ * sqrt(fictTimeKZ)) / 92;

      opirXC = (napruga2 * napruga2) / potKZ2;
      opirXT = (napruga2 / 100) * (napruga2 * napruga2) / sNomt2;
      sumaOpir = opirXC! + opirXT!;
      pochStrym = napruga2 / (sqrt(3) * sumaOpir!);

      reaktOpir = (umax3 * uVn3 * uVn3) / (100 * sNomt2);
      xSh3Res = xSn3 + reaktOpir!;
      xShmin3Res = xSmin3 + reaktOpir!;
      zSh3Res = sqrt(rSn3 * rSn3 + xSh3Res! * xSh3Res!);
      zShmin3Res = sqrt(rSmin3 * rSmin3 + xShmin3Res! * xShmin3Res!);

      iSh3Res = (uVn3 * 10 * 10 * 10) / (sqrt(3) * zSh3Res!);
      iSh23Res = iSh3Res! * sqrt(3) / 2;
      iShmin3Res = (uVn3 * 10 * 10 * 10) / (sqrt(3) * zShmin3Res!);
      iShmin23Res = iShmin3Res! * sqrt(3) / 2;

      kPrRes = pow((umax3 / uVn3), 2).toDouble();
    });
  }

  Widget dataRow(String label, double? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Text(value != null ? value.toStringAsFixed(2) : '-'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Розрахунок струму трифазного КЗ, струму однофазного КЗ та перевірки на стійкість',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
          ),
          SizedBox(height: 16),
          Text('Вхідні дані:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          dataRow('Струм КЗ I_k (kA):', strymKZ),
          dataRow('Напруга U (кВ):', napryga),
          dataRow('Фіктивний час вимикання t_ф (с):', fictTimeKZ),
          dataRow('Потужність ТП (кВ*А):', potTP),
          dataRow('Розрахункове навантаження S_м (кВ*А):', rozNav),
          dataRow('T_м (год):', tm),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: calculate,
            child: Text('Обчислити'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          SizedBox(height: 16),
          Text('Результати:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[700])),
          dataRow('Розрахунковий струм нормального режиму:', rozStrymNormAv),
          dataRow('Розрахунковий струм післяаварійного режиму:', rozStrymAv),
          dataRow('Економічний переріз s_ек (мм²):', ecoPerer),
          dataRow('s >= s_min (мм²):', ss),
          dataRow('Опір X_C:', opirXC),
          dataRow('Опір X_T:', opirXT),
          dataRow('Сумарний опір:', sumaOpir),
          dataRow('Початковий струм:', pochStrym),
          dataRow('Реактивний опір трансформатора:', reaktOpir),
          dataRow('X_sh3:', xSh3Res),
          dataRow('X_sh_min3:', xShmin3Res),
          dataRow('Z_sh3:', zSh3Res),
          dataRow('Z_sh_min3:', zShmin3Res),
          dataRow('I_sh3:', iSh3Res),
          dataRow('I_sh23:', iSh23Res),
          dataRow('I_sh_min3:', iShmin3Res),
          dataRow('I_sh_min23:', iShmin23Res),
          dataRow('k_pr:', kPrRes),
        ],
      ),
    );
  }
}
