import 'dart:math';

import 'package:flutter/material.dart';

import '../screens/recap_rdv.dart';
import '../utils/colors.dart';

class Indisponible extends StatefulWidget {
  const Indisponible({Key? key}) : super(key: key);

  @override
  State<Indisponible> createState() => _IndisponibleState();
}

class _IndisponibleState extends State<Indisponible> {

  Widget _button(String texte, bool disponible){
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Recap_RDV(),
          ),
        );
      },
      child: Text(texte),
      style: ElevatedButton.styleFrom(
        foregroundColor: disponible ? couleur_disponible[1] : couleur_indisponible[1],
        backgroundColor: disponible ? couleur_disponible[0] : couleur_indisponible[0],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0), // Coins arrondis
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width : screenWidth,
      child : Column(
        children : [
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width : screenWidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : [
                Text(
                  'Balayage classique',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6000000238418579),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Row(
                  children : [
                    Text(
                      '40 €',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color(0xFFE32121),
                        fontSize: 10,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    SizedBox(width : 10),
                    Text(
                      '35 €',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ]
                )
              ]
            ),
          ),
          SizedBox(height : 10),
          Text(
            'Aujourd’hui, lundi 24 novembre',
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height : 10),
          Wrap(
            children : [0,1,2,3,4,5,6,7,8,9,10,11].map((item){
              bool randomBool = Random().nextBool();
              return Wrap(
                children : [_button("00:00", randomBool), SizedBox(width : 10),]
              );
            }).toList()
          ),
          SizedBox(height : 10),
        ]
      )
    );
  }
}
