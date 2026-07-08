class Repo{
  final String name;
  final bool prive;

  Repo({
    required this.name,
    required this.prive,
  });

  factory Repo.fromJson(
      Map<String, dynamic> json,
      ){class Repo{
  final String name;
  final bool prive;

  Repo({
  required this.name,
  required this.prive,
  });

  factory Repo.fromJson(
  Map<String, dynamic> json,
  ){
  return Repo(name : json['name'], prive: json['private'] );
  }
  }
    return Repo(name : json['name'], prive: json['private'] );
  }
}