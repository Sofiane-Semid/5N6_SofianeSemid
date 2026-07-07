class Cinema{
  final int age;
  final String jour;
  final String categorie;
  final int prixBase;
  final int rabais;
  final int prixFinal;
  final String message;

  Cinema({
    required this.age,
    required this.jour,
    required this.categorie,
    required this.prixBase,
    required this.rabais,
    required this.prixFinal,
    required this.message,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      age: json['age'],
      jour: json['jour'],
      categorie: json['categorie'],
      prixBase: json['prixBase'],
      rabais: json['rabais'],
      prixFinal: json['prixFinal'],
      message: json['message'],



    );
  }
}
