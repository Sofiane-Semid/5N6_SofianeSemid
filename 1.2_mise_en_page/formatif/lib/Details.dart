import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Details(title: 'Acceuil'),
    );
  }
}

class Details extends StatefulWidget {
  const Details({super.key, required this.title});

  final String title;

  @override
  State<Details> createState() => _Details();
}

class _Details extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
              child: Container(
                height: 200,
                color: Colors.orange,
                child: Center(child: Text("C'est réussi")),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Revenir à l'accueil"),
            ),
          
          ],
        ),
      )

    );
  }

}