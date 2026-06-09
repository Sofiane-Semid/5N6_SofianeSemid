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
      title: 'Plein de containers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice plein de containers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(width: double.infinity, height: 200, color: Colors.red),
            Container(width: double.infinity, height: 200, color: Colors.blue),
            Container(width: double.infinity, height: 200, color: Colors.green),
            Container(width: double.infinity, height: 200, color: Colors.orange),
            Container(width: double.infinity, height: 200, color: Colors.purple),
            Container(width: double.infinity, height: 200, color: Colors.yellow),
            Container(width: double.infinity, height: 200, color: Colors.pink),
            Container(width: double.infinity, height: 200, color: Colors.brown),
            Container(width: double.infinity, height: 200, color: Colors.cyan),
            Container(width: double.infinity, height: 200, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}