
import '../utils/constants.dart';
import '../utils/fn_global.dart';

class Creneau {
  // Propriétés privées
  DateTime _date;
  Etat _etat;
  DateTime _creneau;
  List membres;

  // Constructeur
  Creneau({
    required DateTime date,
    required Etat etat,
    required DateTime creneau,
    required this.membres,
  })  : _date = date,
        _etat = etat,
        _creneau = creneau;

  // Méthodes pour récupérer les valeurs
  DateTime get date => _date;
  Etat get etat => _etat;
  DateTime get creneau => _creneau;


  // Méthodes pour modifier les valeurs
  set date(DateTime newDate) {
    _date = newDate;
  }

  set etat(Etat newEtat) {
    _etat = newEtat;
  }

  set creneau(DateTime newCreneau) {
    _creneau = newCreneau;
  }

  // Créer un objet Team à partir d'un document Firestore
  factory Creneau.fromFirestore(Map<String, dynamic> json) {
    return Creneau(
      date: json['date'].toDate(),
      etat: getEtat(json['etat']),
      creneau: json['creneau'].toDate(),
      membres: json['membres'],
    );
  }

  // Méthode pour afficher les informations du créneau
  @override
  String toString() {
    return 'Creneau(date: $_date, etat: $_etat, creneau: $_creneau, membres : $membres)';
  }

  // Méthode toMap pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'date': _date.toIso8601String(),
      'etat': _etat.toString(), // Si _etat est une énumération, vous devrez peut-être en convertir la valeur en chaîne de caractères
      'creneau': _creneau.toIso8601String(),
      'membres' : membres,
    };
  }

  // Méthode fromMap pour reconstruire l'objet depuis un Map
  factory Creneau.fromMap(Map<String, dynamic> map) {
    return Creneau(
      date: DateTime.parse(map['date']),
      etat: Etat.values.firstWhere((e) => e.toString() == map['etat']), // Conversion de l'état depuis une chaîne de caractères
      creneau: DateTime.parse(map['creneau']),
      membres: map['membres'],
    );
  }
}


