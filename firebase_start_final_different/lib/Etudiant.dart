import 'package:flutter/material.dart';

class Etudiant extends StatelessWidget {
  final String nom;
  final String prenom;
  final bool complete;
  final String message;

  const Etudiant({
    super.key,
    required this.nom,
    required this.prenom,
    required this.message,
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
            Text("Nom Complet : $nom + $prenom"),
            Text("État : $complete"),
            Text("Message : $message")
          ],
        ),
      ),
    );
  }
}