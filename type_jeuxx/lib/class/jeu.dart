class Jeu {
  final String nom;
  final String type;
  final String plateforme;
  final int evaluation;
  final String dateSortie;

  const Jeu({
    required this.nom,
    required this.type,
    required this.plateforme,
    required this.evaluation,
    required this.dateSortie,
  });

  factory Jeu.fromJson(Map<String, dynamic> json) {
    return Jeu(
      nom: json['nom'] ?? '',
      type: json['type'] ?? '',
      plateforme: json['plateforme'] ?? '',
      evaluation: (json['evaluation'] as num?)?.toInt() ?? 0,
      dateSortie: json['dateSortie'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'type': type,
      'plateforme': plateforme,
      'evaluation': evaluation,
      'dateSortie': dateSortie,
    };
  }
}