import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'DetailJeu.dart';
import 'class/jeu.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn.instance.initialize(
    serverClientId: "745033354771-0jk9sf0no8ar3labmpag2d9kk9a0eq3e.apps.googleusercontent.com",
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
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in! ' + user.email!);
      }
    }
    );
    initFirebase();
  }

  void initFirebase() async{
    await Firebase.initializeApp();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Déclencher le flow d'authentification
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // Obtenir les détails d'authorisation de la requête
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final GoogleSignInClientAuthorization? authorizationClient =
    await googleUser.authorizationClient.authorizationForScopes(['email']);

    // Créer de nouvelles informations de connexion
    final credential = GoogleAuthProvider.credential(
      accessToken: authorizationClient!.accessToken,
      idToken: googleAuth.idToken,
    );

    // Une fois connecté, retourner UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> sauvegarderUtilisateur() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'nom': user.displayName ?? 'Sans nom',
        'courriel': user.email ?? '',
      });
    }
  }

  void login() async {
    await signInWithGoogle();
    await sauvegarderUtilisateur();
    getJeux();
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
  }

  CollectionReference<Jeu> getJeuCollection() {
    User? user = FirebaseAuth.instance.currentUser;

    return FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('Jeux')
        .withConverter<Jeu>(
      fromFirestore: (snapshot, _) => Jeu.fromJson(snapshot.data()!),
      toFirestore: (jeu, _) => jeu.toJson(),
    );
  }


  void CreateGame() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connecte-toi avant de créer un jeu')),
      );
      return;
    }

    Jeu nouveauJeu = const Jeu(
      nom: 'Gta 5',
      type: 'Action',
      plateforme: 'PS3',
      evaluation: 9,
      dateSortie: '2013-09-17',
    );

    CollectionReference<Jeu> jeuxCollection = getJeuCollection();
    await jeuxCollection.add(nouveauJeu);

    getJeux();
  }
  List<QueryDocumentSnapshot<Jeu>> jeuDocs = [];

  Future<void> getJeux() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        jeuDocs = [];
      });
      return;
    }

    CollectionReference<Jeu> jeuxCollection = getJeuCollection();
    var resultats = await jeuxCollection.get();

    setState(() {
      jeuDocs = resultats.docs;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text('login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: logout,
                  child: const Text('logout'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: CreateGame,
                  child: const Text('Creer jeu'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: getJeux,
                  child: const Text('get jeux'),
                ),
              ),
            ],
          ),

          Expanded(
            child: ListView(
              children: jeuDocs.isNotEmpty
                  ? jeuDocs.map<Widget>((doc) {
                Jeu jeu = doc.data();

                return ListTile(
                  title: Text(jeu.nom),
                  subtitle: Text('${jeu.type} - ${jeu.plateforme}'),
                  trailing: Text('${jeu.evaluation}/10'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailJeuPage(jeu: jeu),
                      ),
                    );
                  },
                );
              }).toList()
                  : [const Center(child: Text('Aucun jeu affiché'))],
            ),
          )
        ],
      ),

    );
  }
}
