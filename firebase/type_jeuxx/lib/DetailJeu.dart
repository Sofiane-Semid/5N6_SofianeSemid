import 'package:flutter/material.dart';
import 'class/jeu.dart';

class DetailJeuPage extends StatelessWidget {
  final Jeu jeu;

  const DetailJeuPage({
    super.key,
    required this.jeu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom : ${jeu.nom}'),
            Text('Type : ${jeu.type}'),
            Text('Plateforme : ${jeu.plateforme}'),
            Text('Évaluation : ${jeu.evaluation}'),
            Text('Date de sortie : ${jeu.dateSortie}'),
          ],
        ),
      ),
    );
  }
}