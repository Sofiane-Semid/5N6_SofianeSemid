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

                                                    //.update : Ça sert à modifier un ou plusieurs champs d’un document existant.
                                                    //.get : sert a obtenir les infos d'un étudiant, lis le document une fois

                                                   //.set : Ça sert à créer ou remplacer un document.
   /* await etudiantsCollection.doc(controller.text).set({
   'nom': 'Semid',
   'prenom': 'Sofiane',
   'complete': false,

                                            Tu peux aussi faire un set sans tout remplacer avec merge: true :

   await etudiantsCollection.doc(controller.text).set({
  'complete': true,
}, SetOptions(merge: true));
   }); */

                                                   //.delete : Ça supprime complètement l’étudiant dans Firestore.
  //await etudiantsCollection.doc(controller.text).delete();

                                                  //.snapshots : Si le document change dans Firestore, ton application se met à jour automatiquement.
  /*StreamBuilder(
  stream: etudiantsCollection.doc(controller.text).snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    var data = snapshot.data!.data() as Map<String, dynamic>;

    return Text(data['nom']);
  },
) */

                                                   //.withConverter : Ça sert à convertir automatiquement les documents Firestore en objets Dart. Psr exemple crée des jeux
  /* final etudiantsCollection =
    FirebaseFirestore.instance.collection('etudiants').withConverter<Etudiant>(
  fromFirestore: (snapshot, _) => Etudiant.fromJson(snapshot.data()!),
  toFirestore: (etudiant, _) => etudiant.toJson(),
);*/

                                                    //Si ta besoin de 2 parametres pour chercher un truc, tu fait ca :
  /*Future<void> getGame() async {
    String nomRecherche = nomController.text.trim();
    int? ventesRecherche = int.tryParse(ventesController.text.trim());

    if (nomRecherche.isEmpty || ventesRecherche == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Entre un nom valide et un nombre de ventes valide"),
        ),
      );
      return;
    }
    QuerySnapshot<Map<String, dynamic>> resultats = await FirebaseFirestore
        .instance
        .collection('Games')
        .where('nom', isEqualTo: nomRecherche)
        .where('ventes', isEqualTo: ventesRecherche)
        .limit(1)
        .get();
    if (resultats.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Aucun jeu trouvé"),
        ),
      );
      return;
    }
    final data = resultats.docs.first.data();

    setState(() {
      nom = data['nom'];
      ventes = data['ventes'];
    });
  }*/

                                    // Si tu cherche le matricule par un TextField et le mettre a jour avec un textField
 /* void getEtudiants() async{
    CollectionReference etudiantsCollection = FirebaseFirestore.instance.collection('etudiants');
    var resultats = await etudiantsCollection.doc(controller.text).get();

    final data = resultats.data() as Map<String, dynamic>;
    setState((){
      nom = data['nom'];
      prenom = data['prenom'];
      complete = data['complete'].toString();
    });

    Future<void> mettreAJour() async{
    try{
      CollectionReference etudiantsCollection = FirebaseFirestore.instance.collection('etudiants');
      await etudiantsCollection.doc(controller.text).update(
          {'complete' : true}
      );
      print("Mise a jour reussi");
    }
    catch(e){
      print("erreur");
    }

  }
}*/

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /*final CollectionReference<Map<String, dynamic>> matriculeCollection =
  FirebaseFirestore.instance.collection('etudiants');*/

  String nom = "";
  String prenom = "";
  String complete = "";

  Future<void> getEtudiant() async {
    try {
      CollectionReference matriculeCollection = FirebaseFirestore.instance.collection('etudiants');
      DocumentSnapshot doc = await matriculeCollection.doc("6222816").get();

      if (doc.exists) {
        print("etudiant recuperer");
        setState(() {
          nom = doc["nom"];
          prenom = doc["prenom"];
          complete = doc["complete"].toString();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> mettreAJour() async {
    try {
      CollectionReference matriculeCollection = FirebaseFirestore.instance.collection('etudiants');
      await matriculeCollection.doc("6222816").update(
          {"complete": true}
      );
      getEtudiant();
      print("mise a jour réussi");

    } catch (e) {
      print(e);
    }
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
        child: Center(
          child: Column(
            children: [
              /* TextField(
                  controller: controller,
                  decoration:  const InputDecoration(labelText: 'Matricule'),
                ),*/
              SizedBox(height: 10),
              //ElevatedButton(onPressed: debugListerMatricules, child: const Text('Debug matricules')),
              ElevatedButton(
                  onPressed: getEtudiant, child: const Text('Obtenir')),
              ElevatedButton(
                  onPressed: mettreAJour, child: const Text('Mettre à jour')),

              Text("Nom : $nom"),
              Text("Prénom : $prenom"),
              Text("Complété : $complete"),

          //Si l’énoncé dit bouton / récupérer / chercher une fois → get().

          /////////////////////////////////////////////////////////////////////////////////////////

           //Si l’énoncé dit temps réel / automatiquement / mise à jour directe → snapshots() + StreamBuilder.

              // StreamBuilder : La liste doit se mettre à jour automatiquement quand Firestore change.

          /*StreamBuilder(
            stream: matriculeCollection.doc("6229260").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var data = snapshot.data!.data() as Map<String, dynamic>;

              return Text(data['nom']);
            },
          )*/
            ],
          ),
        ),
      ),
    );
  }
}
