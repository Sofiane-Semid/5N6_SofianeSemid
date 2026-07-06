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
  final TextEditingController controller = TextEditingController();

  String nom = "";
  String prenom = "";
  String message = "";
  String complete = "";

  void chercher() async {
    CollectionReference etudiantsCollection =
    FirebaseFirestore.instance.collection('etudiants');

    var resultats = await etudiantsCollection
        .doc(controller.text.trim())
        .get();

    if (resultats.exists) {
      final data = resultats.data() as Map<String, dynamic>;

      setState(() {
        nom = data['nom'];
        prenom = data['prenom'];
        complete = data['complete'].toString();
        message = "";
      });
    } else {
      setState(() {
        nom = "";
        prenom = "";
        complete = "";
        message = "Aucun étudiant trouvé";
      });
    }
  }

  void verifierCompletion() async {
    CollectionReference etudiantsCollection =
    FirebaseFirestore.instance.collection('etudiants');

    var resultats = await etudiantsCollection
        .doc(controller.text)
        .get();

    if (resultats.exists) {
      final data = resultats.data() as Map<String, dynamic>;

      bool estComplete = data['complete'];

      setState(() {
        complete = estComplete.toString();

        if (estComplete == true) {
          message = "Cet étudiant a terminé l'exercice";
        } else {
          message = "Cet étudiant n'a pas encore terminé";
        }
      });
    } else {
      setState(() {
        message = "Aucun étudiant trouvé";
      });
    }
  }

  void reinitialiser() async {
    CollectionReference etudiantsCollection =
    FirebaseFirestore.instance.collection('etudiants');

    await etudiantsCollection
        .doc(controller.text)
        .update({'complete': false});

    setState(() {
      complete = "false";
      message = "Étudiant réinitialisé";
    });
  }

  void mettreAJour() async {
    CollectionReference etudiantsCollection =
    FirebaseFirestore.instance.collection('etudiants');

    await etudiantsCollection
        .doc(controller.text)
        .update({'complete': true});

    setState(() {
      complete = "true";
      message = "Étudiant mis à jour";
    });
  }

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
              decoration: const InputDecoration(labelText: 'Matricule'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: chercher, child: const Text('Chercher'),),
            ElevatedButton(onPressed: verifierCompletion, child: const Text('Vérifier complétion'),),
            ElevatedButton(onPressed: reinitialiser, child: const Text('Réinitialiser'),),
            ElevatedButton(onPressed: mettreAJour, child: const Text('Mettre à jour à true'),),

            const SizedBox(height: 20),

            Text("Nom Complet : $prenom $nom"),
            Text("État : $complete"),
            Text("Message : $message"),
          ],
        ),
      ),
    );
  }
}