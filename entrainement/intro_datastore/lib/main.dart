import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  void initState(){
    initFirebase();
  }

  void initFirebase() async{
    await Firebase.initializeApp();
  }

  String nom = "";
  int ventes = 0;

  TextEditingController nomController = TextEditingController();
  TextEditingController venteController = TextEditingController();

  var jeuDocs;
  Future<void> getGame() async{
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('Jeux');
    var resultats = await jeuxCollection.get();
    jeuDocs = resultats.docs;

    setState((){});
  }

  Future<void> createGame() async{
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('Jeux');
    jeuxCollection.add({
      'Nom' : 'Gta 1',
      'Ventes' : 5

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Center(
        child : Column(
          mainAxisAlignment: .start,
          children: <Widget> [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(onPressed: createGame, child: Text('add jeux')),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(onPressed: getGame, child: Text('get jeux')),
                )
              ],
            ),
            Expanded(
                child: ListView(
                    children:
                    (jeuDocs != null)?
                    jeuDocs.map<Widget>((j) => ElevatedButton(
                      child: Text(j['Nom']),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailJeuPage(nom: j['Nom'], ventes: j['Ventes'],),
                          ),
                        );
                      },
                    )).toList()
                        : [Text('rien')]
                )
            )


          ],

      ),
      )

    );
  }
}
