import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(ESP32App());
}

class ESP32App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 LED Control',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentTemperature = 25.0; // Temperatura inicial
  bool isLedOn = false; // Estado do LED

  Timer? timer; // Timer para atualização automática

  @override
  void initState() {
    super.initState();
    // Atualiza temperatura a cada 30 segundos
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      updateTemperature();
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancela o timer ao sair da tela
    super.dispose();
  }

  void updateTemperature() {
    setState(() {
      // Gera uma temperatura aleatória entre 30 e 50
      currentTemperature = Random().nextDouble() * 20 + 30;

      // Se a temperatura for maior que 45, liga o LED
      if (currentTemperature > 45) {
        isLedOn = true;
      } else {
        isLedOn = false;
      }
    });
  }

  void refreshManually() {
    setState(() {
      // Reseta o estado do LED e gera nova temperatura
      isLedOn = false;
      currentTemperature = Random().nextDouble() * 20 + 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 LED Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temperatura Atual: ${currentTemperature.toStringAsFixed(2)} °C',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'LED está ${isLedOn ? 'Ligado' : 'Desligado'}',
              style: TextStyle(
                fontSize: 24,
                color: isLedOn ? Colors.red : Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: refreshManually,
              child: Text('Atualizar Manualmente'),
            ),
          ],
        ),
      ),
    );
  }
}
