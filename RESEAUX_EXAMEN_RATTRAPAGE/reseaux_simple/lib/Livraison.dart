class Livraison{
  final int distance;
  final int poids;
  final int fraisDistance;
  final int fraisPoids;
  final int total;
  final bool livraisonGratuite;


  Livraison({
    required this.distance,
    required this.poids,
    required this.fraisDistance,
    required this.fraisPoids,
    required this.total,
    required this.livraisonGratuite

  });

  factory Livraison.fromJson(Map<String, dynamic> json) {
    return Livraison(
      distance: json['distance'],
      poids: json['poids'],
      fraisDistance: json['fraisDistance'],
      fraisPoids: json['fraisPoids'],
      total: json['total'],
      livraisonGratuite: json['livraisonGratuite'],
    );
  }
}
