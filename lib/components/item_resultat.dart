import 'package:ablv2/components/note.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Item_Resultat extends StatelessWidget {

  Widget _day(String day, bool free){
    return Container(
        width: 64.12,
        height: 20.24,
      decoration: ShapeDecoration(
        color: free ? Color(0x2B656C67) : dayNoFree,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child : Center(
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6499999761581421),
            fontSize: 9,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Column(
        children: [
          Container(
            width: 393,
            height: 142,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/institut.png"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height : 10),
          Container(
            width : screenWidth,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'AB Beauty Salon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  right : 0,
                  child: AvisNote(),
                ),
              ],
            ),
          ),
          SizedBox(height : 5),
          Text(
            '    124 rue de la gare, 75 000 Paris',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          SizedBox(height : 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(
                'Disponibilités',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                'Promo en cours - 10%',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFFFC0707),
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ]
          ),
          SizedBox(height : 15),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Text(
                'Matin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),

              Row(
                children : [
                  _day('Dim. 31', true), SizedBox(width : 10),
                  _day('Dim. 31', true), SizedBox(width : 10),
                  _day('Dim. 31', false), SizedBox(width : 10),
                  _day('Dim. 31', false), SizedBox(width : 10),
                ]
              )
            ]
          ),
          SizedBox(height : 15),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : [
                Text(
                  'Après-midi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),

                Row(
                    children : [
                      _day('Dim. 31', true), SizedBox(width : 10),
                      _day('Dim. 31', true), SizedBox(width : 10),
                      _day('Dim. 31', false), SizedBox(width : 10),
                      _day('Dim. 31', false), SizedBox(width : 10),
                    ]
                )
              ]
          )
        ],
      ),
    );
  }
}