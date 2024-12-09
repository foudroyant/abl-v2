import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/creneau.dart';
import '../models/institut.dart';
import '../models/prestation.dart';
import '../screens/recap_rdv.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/fn_global.dart';

class Indisponible extends StatefulWidget {
  final DateTime day;
  final Prestation service;
  final List<Option> options;
  final Institut institut;
  const Indisponible({Key? key, required this.day, required this.service, required this.options, required this.institut,}) : super(key: key);

  @override
  State<Indisponible> createState() => _IndisponibleState();
}

class _IndisponibleState extends State<Indisponible> {

  late DateTime open ;
  late DateTime close;

  @override
  initState(){

    setState((){
      open = DateTime.parse(widget.institut.horaires[get_jour(widget.day)]['Ouverture'][0]);
      close = DateTime.parse(widget.institut.horaires[get_jour(widget.day)]['Ouverture'][1]);
    });
  }

  Widget _button(Creneau creneau, bool disponible){
    return InkWell(
      onTap: () {
        if(disponible){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Recap_RDV(
                institut: widget.institut, prestation: widget.service, options: widget.options, jour: widget.day, creneau: creneau
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top : 5, bottom : 5),
        child: Container(
            width: 65,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: ShapeDecoration(
              color: disponible ? Color(0xFF0F72C9) :  Color(0x33439FF0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            ),
            child: Center(
              child: Text("${creneau.creneau.hour}:${creneau.creneau.minute}", textAlign: TextAlign.center,
                style: TextStyle(
                  color: disponible ? Colors.white : Color(0xFFB5ADAD),
                  fontSize: 10,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w700,
                ),),
            )
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
                  widget.service.nom,
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
                      '${widget.service.prix} €',
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
            formaterDate(widget.day),
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height : 10),
          Wrap(
            children : genererCreneaux(open,close).map((item){
              bool randomBool = Random().nextBool();
              bool etat = item.etat == Etat.DISPONIBLE;

              return Wrap(
                children : [_button(item, etat), SizedBox(width : 10),]
              );
            }).toList()
          ),
          SizedBox(height : 10),
        ]
      )
    );
  }
}
