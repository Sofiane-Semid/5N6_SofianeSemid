import 'package:flutter/material.dart';

class Etudiant extends StatelessWidget {
  final String nom;
  final String prenom;
  final bool complete;

  const Etudiant({
    super.key,
    required this.nom,
    required this.prenom,
    this.complete = false,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("l'étudiant"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Prenom : $prenom"),
            Text("Nom : $nom"),
            Text("Complété : $complete")
          ],
        ),
      ),
    );
  }
}