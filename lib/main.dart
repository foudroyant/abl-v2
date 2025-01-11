import 'package:ablv2/screens/auth/screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/institut.dart';
import 'models/institut_provider.dart';
import 'models/utils.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Institut> instituts = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  initState() {
    print(user);
    /*ajouterCreneauIndisponible("9fBQAwyed5eEkPtWd0o3", {
      "date": DateTime(2025, 1, 8), // Date actuelle
      "etat": 1, // Exemple d'état
      "creneau": DateTime(2025, 1, 8, 14, 0, 0), // DateTime directement défini
    });*/
  }

  Future<void> ajouterCreneauIndisponible(String institut, Map<String, dynamic> creneau) async {
    // Récupérer la collection 'creneaux_indisponibles' pour un institut spécifique
    CollectionReference creneauCollection = FirebaseFirestore.instance
        .collection("instituts")
        .doc(institut)
        .collection("creneaux_indisponibles");

    try {
      // Ajouter un document à la collection "creneaux_indisponibles"
      DocumentReference newCreneauRef = await creneauCollection.add(creneau);
      print("Creneau ajouté avec l'ID : ${newCreneauRef.id}");
    } catch (error) {
      print("Erreur lors de l'ajout du créneau : $error");
    }
  }



  // Fonction pour récupérer les instituts par catégorie
  Future<void> getInstitutsByCategory() async {

    // Référence à la collection 'instituts'
    CollectionReference institutsCollection = FirebaseFirestore.instance.collection('instituts');

    try {
      // Effectuer la requête pour récupérer les instituts dont la catégorie contient la chaîne de caractères
      QuerySnapshot snapshot = await institutsCollection
          //.where('categories', isGreaterThanOrEqualTo: category)
          //.where('categories', isLessThanOrEqualTo: category + '\\uf8ff')
          .get();


      // Traitez les résultats
      setState(() {
        instituts = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>; // Explicit cast to Map
          final List<Map<String, dynamic>> _promotions = data['promotions'] ?? [];
          final __promotions = _promotions.map((p){
            return Promotion.fromMap(p);
          }).toList();

          return Institut(
            id: doc.id,
            nom: doc['nom'],
            localisation: doc['localisation'],
            ville: doc['ville'],
            pays: doc['pays'],
            telephone: doc['telephone'],
            images: List<String>.from(doc['images']),
            categories: doc['categories'],
            adresse: doc['adresse'],
            tendance: doc['tendance'],
            horaires: doc['horaires'],
            promotions: __promotions,
          );
        }).toList();
      });
    } catch (e) {
      print("Error retrieving institutes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    getInstitutsByCategory();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Utils(),
        ),
        ChangeNotifierProvider(
          create: (context) => Institut_Provider(instituts: instituts),
        ),
      ],
      child: MaterialApp(
        title: 'ABL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

