import 'package:ablv2/screens/prendre_rdv.dart';
import 'package:ablv2/screens/profile_institut.dart';
import 'package:ablv2/screens/rdv.dart';
import 'package:ablv2/screens/recap_rdv.dart';
import 'package:ablv2/screens/recherche_abp.dart';
import 'package:ablv2/screens/resultats.dart';
import 'package:flutter/material.dart';
import '/components/annonce.dart';
import '/components/header.dart';
import '/screens/home.dart';
import '/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'ABL',
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
