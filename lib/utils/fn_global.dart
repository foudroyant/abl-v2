import '../models/creneau.dart';
import 'constants.dart';
import 'package:intl/intl.dart';

List<String> moisFrancais = [
  'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
  'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
];

List<Creneau> generateIndisponibles() {
  List<Creneau> indisponibles = [];
  for (int i = 0; i < 10; i++) {
    DateTime date = DateTime(2024, 12, i + 5, 8 + i); // Exemple de date et heure
    Creneau creneau = Creneau(
      date: date,
      etat: i%3==0 ? Etat.INDISPONIBLE : Etat.HC,
      creneau: date.add(Duration(hours: 1)), // Créneau d'une heure
    );

    indisponibles.add(creneau);
  }
  return indisponibles;
}

List<Creneau> genererCreneaux(DateTime heureDebut, DateTime heureFin) {
  List<Creneau> creneaux = [];
  List<Creneau> indisponibles = generateIndisponibles();

  DateTime prochainCreneau = heureDebut;
  while (prochainCreneau.isBefore(heureFin)) {
    List<Creneau> _indisp = indisponibles.where((_i) {
      return _i.creneau.isAtSameMomentAs(prochainCreneau);
    }).toList();

    // Formater la clé 'creneau' pour avoir toujours les heures et minutes à deux chiffres
    String creneauFormate = DateFormat('HH:mm').format(prochainCreneau);

    // La clé 'date' aura toujours l'heure à 00:00
    DateTime dateSansHeure = DateTime(prochainCreneau.year, prochainCreneau.month, prochainCreneau.day, 0, 0);

    if (_indisp.isNotEmpty) {
      creneaux.add(Creneau(
        date: dateSansHeure,  // La date est à 00:00
        etat: _indisp[0].etat,
        creneau: prochainCreneau,  // Le créneau garde l'heure et la minute
      ));
    } else {
      creneaux.add(Creneau(
        date: dateSansHeure,  // La date est à 00:00
        etat: Etat.DISPONIBLE,
        creneau: prochainCreneau,  // Le créneau garde l'heure et la minute
      ));
    }

    // Ajouter un intervalle de 30 minutes pour le prochain créneau
    prochainCreneau = prochainCreneau.add(Duration(minutes: 30));
  }

  return creneaux;
}


List<DateTime> getWeekDates(DateTime inputDate) {
  // Trouver le début de la semaine (lundi)
  final int weekday = inputDate.weekday; // 1 = Lundi, ..., 7 = Dimanche
  final DateTime startOfWeek = inputDate.subtract(Duration(days: weekday - 1));

  // Générer les 7 dates de la semaine
  return List<DateTime>.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}


String formaterDate(DateTime date) {
  // Liste des jours en français
  List<String> joursFrancais = [
    'Dimanche', 'Lundi', 'Mardi', 'Mercredi',
    'Jeudi', 'Vendredi', 'Samedi'
  ];
  // Extraire le jour, le mois et l'année
  String jour = joursFrancais[date.weekday % 7]; // Lundi = 1, Dimanche = 0
  String mois = moisFrancais[date.month - 1]; // Mois commence à 1
  String jourDuMois = date.day.toString().padLeft(2, '0'); // Ajouter un zéro si nécessaire
  int annee = date.year;

  print(jour);

  return '$jour $jourDuMois $mois $annee';
}