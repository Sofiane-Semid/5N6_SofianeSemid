import 'package:flutter/material.dart';


// NE SERT A RIEN sauf quand il demande avec withconverter

class Etudiant {
  final String nom;
  final String prenom;
  final bool complete;

  Etudiant({
    required this.nom,
    required this.prenom,
    required this.complete,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      nom: json['nom'],
      prenom: json['prenom'],
      complete: json['complete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'complete': complete,
    };
  }
}