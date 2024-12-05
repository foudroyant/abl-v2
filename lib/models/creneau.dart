
import '../utils/constants.dart';

class Creneau {
  // Propriétés privées
  DateTime _date;
  Etat _etat;
  DateTime _creneau;

  // Constructeur
  Creneau({
    required DateTime date,
    required Etat etat,
    required DateTime creneau,
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

  // Méthode pour afficher les informations du créneau
  @override
  String toString() {
    return 'Creneau(date: $_date, etat: $_etat, creneau: $_creneau)';
  }
}

