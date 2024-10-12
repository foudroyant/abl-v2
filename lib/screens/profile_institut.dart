import 'package:flutter/material.dart';

import '../components/photo_institut.dart';
import '../components/presentation.dart';
import '../components/ui_shared.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';

class Profil_Institut extends StatefulWidget {
  const Profil_Institut({Key? key}) : super(key: key);

  @override
  State<Profil_Institut> createState() => _Profil_InstitutState();
}

class _Profil_InstitutState extends State<Profil_Institut> {

  Widget textInglet(String texte){
    return Text(
      texte,
      style: TextStyle(
        color: Color(0xFF303030),
        fontSize: 17,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        height: 0.07,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appBar_shared(context, 'AB Beauty Salon', '124 rue de la gare, 75 000 Paris - France'),
        body : Column(
            children : [
              Photo_Institut(),
              TabBar(
                isScrollable: true,
                  labelStyle : tabBarStyle,
                tabs: [
                  Tab(text: 'Prestations'),
                  Tab(text: 'Offres'),
                  Tab(text: 'Réalisations'),
                  Tab(text: 'À propos'),
                ],
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(child: Presentation()), // Contenu de l'onglet 1
                    Center(child: Text('Contenu de l\'Onglet 2')), // Contenu de l'onglet 2
                    Center(child: Text('Contenu de l\'Onglet 3')), // Contenu de l'onglet 3
                    Center(child: Text('Contenu de l\'Onglet 4')), // Contenu de l'onglet 4
                  ],
                ),
              ),
            ]
          )
      ),
    );
  }
}
