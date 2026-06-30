import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'DetailJeu.dart';
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

  void login() {
    signInWithGoogle();
}

  void logout() async{
    await FirebaseAuth.instance.signOut();
  }

  CollectionReference getJeuCollection(){
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Jeux');
  }


  void addJeux() async {
    CollectionReference jeuxCollection = getJeuCollection();

    jeuxCollection.add({
      'Nom' : 'Gta 4',
      'Ventes' : 1

    });
  }
  var jeuDocs;

  void getJeux() async {
    CollectionReference jeuxCollection = getJeuCollection();
    var resultats = await jeuxCollection.get();
    jeuDocs = resultats.docs;

    setState((){});
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
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(onPressed: addJeux, child: Text('add jeux')),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(onPressed: getJeux, child: Text('get jeux')),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(onPressed: logout, child: Text('logout')),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(onPressed: login, child: Text('login')),
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
      ),

    );
  }
}
