import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Etudiant.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firestore'),
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
  // Future<void> debugListerMatricules() async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('etudiants')
  //         .get();
  //     debugPrint('----- LISTE DES MATRICULES -----');
  //     for (final doc in snapshot.docs) {
  //       debugPrint('Matricule : ${doc.id}');
  //       debugPrint('Données : ${doc.data()}');
  //     }
  //     debugPrint('----- FIN -----');
  //   } catch (e) {
  //     debugPrint('Erreur Firestore : $e');
  //   }
  // }

  void getEtudiants() async{
    CollectionReference etudiantsCollection = FirebaseFirestore.instance.collection('etudiants');
    var resultats = await etudiantsCollection.doc(controller.text).get();

    final data = resultats.data() as Map<String, dynamic>;
    setState((){
      nom = data['nom'];
      prenom = data['prenom'];
      complete = data['complete'].toString();
    });
  }

  void mettreAJour() async{
    CollectionReference etudiantsCollection = FirebaseFirestore.instance.collection('etudiants');
    await etudiantsCollection.doc(controller.text).update(
        {'complete' : true}
    );
    setState((){
      complete = "true";
    });
  }


  final TextEditingController controller = TextEditingController();
  String nom = "";
  String prenom = "";
  String complete = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration:  const InputDecoration(labelText: 'Matricule'),
              ),
              SizedBox(height: 10),
              //ElevatedButton(onPressed: debugListerMatricules, child: const Text('Debug matricules')),
              ElevatedButton(onPressed: getEtudiants, child: const Text('Obtenir')),
              ElevatedButton(onPressed: mettreAJour, child: const Text('Mettre à jour')),

              Text("Nom : $nom"),
              Text("Prénom : $prenom"),
              Text("Complété : $complete"),
            ],
          ),
      ),
        );
  }
}
