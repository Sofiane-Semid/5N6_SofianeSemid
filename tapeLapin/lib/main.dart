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
      title: 'Tape Le Lapin',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Tape le lapin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indexLapin = Random().nextInt(4);

  int _flops = 0;
  int _pafs = 0;



  void gererTape(int index){
    print('Bouton' + index.toString());
    if(this._indexLapin == index){
      this._pafs++;
      _indexLapin = Random().nextInt(4);
    }else{
      this._flops++;
    }
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    print(this._indexLapin);
    var b0 = MaterialButton(
        onPressed: () {
          gererTape(0);
        },
        child: Text(this._indexLapin == 0 ? 'Lapin' : 'Taupe'),
    );
    var b1 = MaterialButton(
      onPressed: () {
        gererTape(1);
      },
      child: Text(this._indexLapin == 1 ? 'Lapin' : 'Taupe'),
    );
    var b2 = MaterialButton(
      onPressed: () {
        gererTape(2);
      },
      child: Text(this._indexLapin == 2 ? 'Lapin' : 'Taupe'),
    );var b3 = MaterialButton(
      onPressed: () {
        gererTape(3);
      },
      child: Text(this._indexLapin == 3 ? 'Lapin' : 'Taupe'),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                b1,
                Text(
                    "Pafs: " + this._pafs.toString(),
                    style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                Text(
                    "Flops: " + this._flops.toString(),
                    style: TextStyle(color: Colors.red, fontSize: 20),
                )
              ],
            ),
            Text(
                'Tape le lapin',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                b0,
                b1,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                b2,
                b3,
              ],

            ),
          ],
        ),
      ),
    );
  }
}
