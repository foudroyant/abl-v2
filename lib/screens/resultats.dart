import 'package:ablv2/screens/profile_institut.dart';
import 'package:flutter/material.dart';

import '../components/item_resultat.dart';
import '../utils/colors.dart';

class Resultats extends StatefulWidget {
  const Resultats({Key? key}) : super(key: key);

  @override
  State<Resultats> createState() => _ResultatsState();
}

class _ResultatsState extends State<Resultats> {

  Widget _button(String icone, String texte){
    return Container(
        width: 75,
        height: 25,
      child : Row(
        children : [
          Image.asset(
            "assets/images/${icone}",
            //width: 60,
            height: 25,
            fit: BoxFit.contain,
          ),
          Text(
            texte,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.699999988079071),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Bouton retour
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            height: 40, // Ajuster la hauteur pour une apparence plus nette
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Salon haut de gamme - Paris 18 ème...',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.black, // Couleur du contour
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.black, // Couleur du contour lorsque le champ est focus
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Espacement interne
              ),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.white, // Couleur du curseur
            ),
          ),
          backgroundColor: appBarColor,
        ),
      body : SafeArea(
        child : SingleChildScrollView(
          child : Column(
            children : [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children : [
                    _button("system-uicons_sort.png", 'Trier'), _button("mi_filter.png", 'Filtrer'), _button("carbon_map.png", 'Carte')
                  ]
              ),
              SizedBox(height : 15),
              Column(
                children: [0,1,2,3].map((item){
                  return InkWell(
                    onTap : (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profil_Institut()
                        ),
                      );
                    },
                    child : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical : 5),
                      child : Item_Resultat(),
                    )
                  );
                }).toList()
              ),
            ]
          )
        )
      )
    );
  }
}
