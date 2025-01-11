class Team {
  String nom;
  String prenom;
  String image;
  String user;
  bool online;

  // Constructeur
  Team({
    required this.nom,
    required this.prenom,
    required this.image,
    required this.user,
    required this.online,
  });

  @override
  String toString() {
    return 'Team(nom: $nom, prenom: $prenom, image: $image, user: $user, online: $online)';
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'image': image,
      'user': user,
      'online': online,
    };
  }

  // Créer un objet Team à partir d'un document Firestore
  factory Team.fromFirestore(Map<String, dynamic> json) {
    return Team(
      nom: json['nom'],
      prenom: json['prenom'],
      image: json['image'],
      user: json['user'],
      online: json['online'],
    );
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      nom: json['nom'],
      prenom: json['prenom'],
      image: json['image'],
      user: json['user'],
      online: json['online'],
    );
  }
}
