
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
  });

  List<String> les_categories(){
    return this.categories.split(",").toSet().toList();
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

