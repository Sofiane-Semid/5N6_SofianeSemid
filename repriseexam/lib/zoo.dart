class Zoo{
  final String continent;
  final String espece;
  final String nom;
  final String famille;

  Zoo({
    required this.continent,
    required this.espece,
    required this.nom,
    required this.famille,
  });

  factory Zoo.fromJson(
      Map<String, dynamic> json,
      ){
    return Zoo(continent : json['continent'], espece: json['espece'], nom: json['nom'], famille: json['famille']);
  }
}