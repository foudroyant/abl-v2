import 'package:flutter/material.dart';

import '../parametre/screnn.dart';
import 'home.dart';
import '../rdv.dart';

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
    Parametres(),
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