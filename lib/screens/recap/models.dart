import '../../models/creneau.dart';
import '../../models/institut.dart';
import '../../models/user.dart';

class Reservation {
  InfoPublic institut;  // L'institut en tant qu'objet InfoPublic
  DateTime date;  // Date de la réservation
  bool alerte;  // Alerte de type bool
  bool addToAgenda;  // Ajouter à l'agenda de type bool
  bool notifierAvant;  // Notification avant un certain délai
  int notifierTantDeTemps;  // Délai en minutes avant la notification
  User_Info userInfo;  // Informations de l'utilisateur
  List<Prestation_Exp> prestations;  // Liste de prestations
  Creneau creneau;
  Person personne;  // Nouvelle clé personne de type Person
  String occurrence;  // Nouvelle clé occurrence de type String

  Reservation({
    required this.institut,
    required this.date,
    required this.alerte,
    required this.addToAgenda,
    required this.notifierAvant,
    required this.notifierTantDeTemps,
    required this.userInfo,
    required this.prestations,
    required this.creneau,
    required this.personne,  // Ajout du paramètre personne
    required this.occurrence,  // Ajout du paramètre occurrence
  });

  // Méthode pour convertir Reservation en Map
  Map<String, dynamic> toMap() {
    return {
      'institut': institut.toMap(),
      'date': date.toIso8601String(),
      'alerte': alerte,
      'addToAgenda': addToAgenda,
      'notifierAvant': notifierAvant,
      'notifierTantDeTemps': notifierTantDeTemps,
      'userInfo': userInfo.toMap(),
      'prestations': prestations.map((prestation) => prestation.toMap()).toList(),
      'creneau': creneau.toMap(),
      'personne': personne.toMap(),  // Conversion de personne en Map
      'occurrence': occurrence,  // Ajout de occurrence
    };
  }

  // Méthode pour créer un objet Reservation à partir d'une Map
  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      institut: InfoPublic.fromMap(map['institut'] ?? {}),
      date: DateTime.parse(map['date'] ?? ''),
      alerte: map['alerte'] ?? false,
      addToAgenda: map['addToAgenda'] ?? false,
      notifierAvant: map['notifierAvant'] ?? false,
      notifierTantDeTemps: map['notifierTantDeTemps'] ?? 0,
      userInfo: User_Info.fromMap(map['userInfo'] ?? {}),
      prestations: List<Prestation_Exp>.from(
        map['prestations']?.map((x) => Prestation_Exp.fromMap(x)) ?? [],
      ),
      creneau: Creneau.fromMap(map['creneau']),
      personne: Person.fromMap(map['personne'] ?? {}),  // Reconstruction de personne depuis Map
      occurrence: map['occurrence'] ?? '',  // Initialisation de occurrence
    );
  }
}



//***************************************************************
class Prestation_Exp {
  String label;
  String temps;  // Par exemple, "1h30" ou "30 minutes"
  double prix;
  String image;  // URL ou nom de l'image

  Prestation_Exp({
    required this.label,
    required this.temps,
    required this.prix,
    required this.image,
  });

  // Convertir Prestation en Map
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'temps': temps,
      'prix': prix,
      'image': image,
    };
  }

  // Créer un objet Prestation à partir d'une Map
  factory Prestation_Exp.fromMap(Map<String, dynamic> map) {
    return Prestation_Exp(
      label: map['label'] ?? '',
      temps: map['temps'] ?? '',
      prix: map['prix'] ?? 0.0,
      image: map['image'] ?? '',
    );
  }
}
