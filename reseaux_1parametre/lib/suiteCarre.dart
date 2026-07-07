class SuiteCarreResultat {
  final int position;
  final int precedent;
  final int valeur;
  final int suivant;
  final bool pair;
  final String message;

  SuiteCarreResultat({
    required this.position,
    required this.precedent,
    required this.valeur,
    required this.suivant,
    required this.pair,
    required this.message
  });

  factory SuiteCarreResultat.fromJson(Map<String, dynamic> json) {
    return SuiteCarreResultat(
      position: json['position'],
      precedent: json['precedent'],
      valeur: json['valeur'],
      suivant: json['suivant'],
      pair: json['pair'],
      message: json['message'],
    );
  }
}

