class Tendance_Model {
  String nom;
  String image;
  String categorie;
  double note;
  String id;

  Tendance_Model({
    required this.id,
    required this.nom,
    required this.image,
    required this.categorie,
    required this.note,
  });

  // Méthode pour afficher les informations de l'institut
  @override
  String toString() {
    return 'Institut(nom: $nom, image: $image, categorie: $categorie, note: $note)';
  }
}