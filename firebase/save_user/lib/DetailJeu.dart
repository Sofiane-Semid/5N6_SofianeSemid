import 'package:flutter/material.dart';

class DetailJeuPage extends StatelessWidget {
  final String nom;
  final int ventes;

  const DetailJeuPage({
    super.key,
    required this.nom,
    required this.ventes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du jeu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom : $nom"),
            Text("Ventes : $ventes"),
          ],
        ),
      ),
    );
  }
}