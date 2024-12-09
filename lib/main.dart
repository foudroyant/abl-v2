import 'package:ablv2/screens/prendre_rdv.dart';
import 'package:ablv2/screens/profile_institut.dart';
import 'package:ablv2/screens/rdv.dart';
import 'package:ablv2/screens/recap_rdv.dart';
import 'package:ablv2/screens/recherche_abp.dart';
import 'package:ablv2/screens/resultats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/components/annonce.dart';
import '/components/header.dart';
import '/screens/home.dart';
import '/utils/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/institut.dart';
import 'models/institut_provider.dart';
import 'models/user.dart';
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
  late User_Model user_model;

  @override
  initState() {
    if(user != null){
      getUserById(user!.uid);
    }
    else {
      User_Model defaultUser = User_Model(
        email: 'default@example.com',
        createdAt: Timestamp.now(),
        personnes: [
          Person(
            nom: 'Default Person',
            telephone: '+242 00 000 00 00',
          ),
        ],
        phoneNumber: '+242 00 000 00 00',
        displayName: 'Default User',
      );
      setState((){
        user_model = User_Model.fromMap(defaultUser.toMap());
      });
    }
  }

 void getUserById(String userId) async {
    try {
      // Accéder au document dans la collection "users"
      DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (document.exists) {
        final _user = document.data() as Map<String, dynamic>; // Retourne les données sous forme de Map
        setState((){
          user_model = User_Model.fromMap(_user);
        });

      } else {
        print("Utilisateur introuvable");
        // Objet par défaut pour User_Model
        User_Model defaultUser = User_Model(
          email: 'default@example.com',
          createdAt: Timestamp.now(),
          personnes: [
            Person(
              nom: 'Default Person',
              telephone: '+242 00 000 00 00',
            ),
          ],
          phoneNumber: '+242 00 000 00 00',
          displayName: 'Default User',
        );
        setState((){
          user_model = User_Model.fromMap(defaultUser.toMap());
        });
      }
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'utilisateur: $e");
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

        ChangeNotifierProvider(
          create: (context) => User_Provider(user: user_model),
        ),
      ],
      child: MaterialApp(
        title: 'ABL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: MyHomePage(
          title: 'ABL',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Liste des pages correspondantes aux éléments de la BottomNavigationBar
  static const List<Widget> _widgetOptions = <Widget>[
    Home(title: 'ABL',),
    Center(child: Text('Conseil Page', style: TextStyle(fontSize: 24))),
    RDV(),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Conseil',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/reservation.png'),
              size: 24, // Taille de l'image
            ),
            label: 'Réservations',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/logo_bottom.png'),
              size: 24, // Taille de l'image
            ),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex, // L'élément sélectionné
        selectedItemColor: Colors.blue, // Couleur de l'élément sélectionné
        unselectedItemColor:
            Colors.grey, // Couleur des éléments non sélectionnés
        onTap: _onItemTapped, // Action lors du clic
      ),
    );
  }
}
