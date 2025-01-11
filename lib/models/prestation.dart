class Prestation {
  String id;
  String nom;
  String description;
  bool a_domicile;
  double prix;
  String duree;
  String categorie;
  String type;
  List<Option> options = [];

  Prestation({
    required this.id,
    required this.nom,
    required this.description,
    required this.a_domicile,
    required this.prix,
    required this.duree,
    required this.categorie,
    required this.type,
  });

  void load_options(List<Option> o) {
    this.options = o;
  }

  // Convertir une instance de Prestation en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'a_domicile': a_domicile,
      'prix': prix,
      'duree': duree,
      'categorie': categorie,
      'type': type,
      'options': options.map((option) => option.toMap()).toList(),
    };
  }

  // Recréer une instance de Prestation depuis un Map
  factory Prestation.fromMap(Map<String, dynamic> map) {
    return Prestation(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      a_domicile: map['a_domicile'],
      prix: map['prix'],
      duree: map['duree'],
      categorie: map['categorie'],
      type: map['type'],
    )..load_options((map['options'] as List<dynamic>)
        .map((optionMap) => Option.fromMap(optionMap))
        .toList());
  }
}

class Option {
  String img;
  String nom;
  String duree;
  double prix;
  bool etat;

  Option({
    required this.img,
    required this.nom,
    required this.duree,
    required this.prix,
    required this.etat,
  });

  // Convertir une instance d'Option en Map
  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'nom': nom,
      'duree': duree,
      'prix': prix,
      'etat': etat,
    };
  }

  // Recréer une instance d'Option depuis un Map
  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      img: map['img'],
      nom: map['nom'],
      duree: map['duree'],
      prix: map['prix'],
      etat: map['etat'],
    );
  }
}
