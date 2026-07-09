import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DetailJeu.dart';
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
      home: const MyHomePage(title: 'Firebase'),
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

                               // Roue de secours si marche pas, pour creer un truc et le recuperer
  /*void addJeux() async {
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('Jeux');
    jeuxCollection.add({
      'Nom' : 'Gta 5',
      'Ventes' : 5

    });
  }
  var jeuDocs;
  void getJeux() async {
    CollectionReference jeuxCollection = FirebaseFirestore.instance.collection('Jeux');
    var resultats = await jeuxCollection.get();
    jeuDocs = resultats.docs;

    setState((){});
  }*/

  final CollectionReference<Map<String, dynamic>> jeuCollection =
  FirebaseFirestore.instance.collection('mdr');

  List<QueryDocumentSnapshot> jeuDocs = [];

  Future<void> addJeux() async {
    try {
      CollectionReference jeuxCollection =
      FirebaseFirestore.instance.collection('mdr');

      await jeuxCollection.add({
        'Nom': 'Gta 3',
        'Ventes': 5,
      });

      print("Jeu ajouté");

      // Pour rafraîchir la liste après l'ajout
      await getJeux();

    } catch (e) {
      print("Erreur lors de l'ajout du jeu : $e");
    }
  }

  Future<void> getJeux() async {
    try {
      CollectionReference jeuxCollection =
      FirebaseFirestore.instance.collection('mdr');

      QuerySnapshot resultats = await jeuxCollection.get();

      setState(() {
        jeuDocs = resultats.docs;
      });

      print("${jeuDocs.length} jeux récupérés");
    } catch (e) {
      print("Erreur lors de la récupération des jeux : $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: <Widget> [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(onPressed: addJeux, child: Text('add jeux')),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(onPressed: getJeux, child: Text('get jeux')),
                )
              ],
            ),
            Expanded(
                child:ListView.builder(
                  itemCount: jeuDocs.length,
                  itemBuilder: (context, index) {
                    final data = jeuDocs[index].data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(data['Nom']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailJeuPage(
                              nom: data['Nom'],
                              ventes: data['Ventes'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                                 // Sa va avec le code en haut roue de secours
              /*ListView(
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
                )*/
            ),

          ],
        ),
      ),

    );
  }
}
