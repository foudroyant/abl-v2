
class Institut {
  String nom;
  String localisation;
  String ville;
  String pays;
  String telephone;
  List<String> images;
  String categories;
  String adresse;
  String tendance;
  String id;
  Map horaires;
  List<Promotion> promotions;

  // Constructeur de la classe
  Institut({
    required this.id,
    required this.nom,
    required this.localisation,
    required this.ville,
    required this.pays,
    required this.telephone,
    required this.images,
    required this.categories,
    required this.adresse,
    required this.tendance,
    required this.horaires,
    required this.promotions
  });

  List<String> les_categories(){
    return this.categories.split(",").toSet().toList();
  }
  InfoPublic toPublicInfo() {
    return InfoPublic(
      nom: this.nom,
      localisation: this.localisation,
      ville: this.ville,
      pays: this.pays,
      telephone: this.telephone,
      images: this.images,
      adresse: this.adresse,
      id: this.id,
      horaires: this.horaires,
    );
  }

  // Méthode toJson pour convertir l'objet en Map (par exemple pour l'envoi à une base de données)
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'localisation': localisation,
      'ville': ville,
      'pays': pays,
      'telephone': telephone,
      'images': images,
      'categories': categories,
      'adresse': adresse,
      'tendance': tendance,
    };
  }
}


class InfoPublic {
  final String nom;
  final String localisation;
  final String ville;
  final String pays;
  final String telephone;
  final List<String> images;
  final String adresse;
  final String id;
  final Map horaires;

  InfoPublic({
    required this.nom,
    required this.localisation,
    required this.ville,
    required this.pays,
    required this.telephone,
    required this.images,
    required this.adresse,
    required this.id,
    required this.horaires,
  });

  // Convertir l'objet InfoPublic en Map
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'localisation': localisation,
      'ville': ville,
      'pays': pays,
      'telephone': telephone,
      'images': images,
      'adresse': adresse,
      'id': id,
      'horaires': horaires,
    };
  }

  // Créer un objet InfoPublic à partir d'une Map
  factory InfoPublic.fromMap(Map<String, dynamic> map) {
    return InfoPublic(
      nom: map['nom'] ?? '',
      localisation: map['localisation'] ?? '',
      ville: map['ville'] ?? '',
      pays: map['pays'] ?? '',
      telephone: map['telephone'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      adresse: map['adresse'] ?? '',
      id: map['id'] ?? '',
      horaires: map['horaires'] ?? {},
    );
  }
}




class Promotion {
  String label;
  String description;
  String code;
  DateTime start;
  DateTime end;
  double pourcentage;

  Promotion({
    required this.label,
    required this.description,
    required this.code,
    required this.start,
    required this.end,
    required this.pourcentage,
  });

  // Convertir une instance de Promotion en Map
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'description': description,
      'code': code,
      'start': start.toIso8601String(), // DateTime en format ISO 8601
      'end': end.toIso8601String(),
      'pourcentage': pourcentage,
    };
  }

  // Recréer une instance de Promotion depuis un Map
  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      label: map['label'],
      description: map['description'],
      code: map['code'],
      start: DateTime.parse(map['start']), // Conversion ISO 8601 en DateTime
      end: DateTime.parse(map['end']),
      pourcentage: map['pourcentage'],
    );
  }
}


