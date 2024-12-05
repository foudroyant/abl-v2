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

  load_options(List<Option> o){
    this.options = o;
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
    required this.etat
  });

}