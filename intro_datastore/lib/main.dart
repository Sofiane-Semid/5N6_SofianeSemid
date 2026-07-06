import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Jeu.dart';
import 'firebase_options.dart';

void main() async {
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
  @override
  void initState(){
    initFirebase();
  }

  void initFirebase() async{
    await Firebase.initializeApp();
  }

  void addGame() async{
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('jeux');
    jeuxCollection.add({
      'Nom' : 'Gta 3',
      'Ventes' : 500
    });
  }

  var jeuDocs;
  void getGame() async{
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('Jeux');
    var resultats = await jeuxCollection.get();
    jeuDocs = resultats.docs;

    setState((){});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(onPressed: addGame, child: Text('add game')),
            ElevatedButton(onPressed: getGame, child: Text('get game')),

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
      ),
    );
  }
}
