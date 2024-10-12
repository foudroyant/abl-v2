import 'package:flutter/material.dart';

import '../screens/prendre_rdv.dart';

class Presentation extends StatelessWidget {
  const Presentation({Key? key}) : super(key: key);


  Widget _team(String texte, String image){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height : 75,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Container(
            width: 50,
            height: 50,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          Text(
            texte,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ]
      ),
    );
  }

  TextSpan text_span(String texte, double size, bool underline){
    return TextSpan(
      text: texte,
      style: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        height: 0,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  Widget _service(BuildContext context, bool at_home){
    return Column(
      children : [
        Text.rich(
        TextSpan(
        children: [
          text_span('Balayage Classique\n', 16, false),
        text_span('\n', 16, false),
        text_span('Cette technique convient à presque tous les types de cheveux et est idéale pour ajouter de la luminosité et de la et est idéale pour ajouter de la luminosité et de la dimension sans un changement radical de couleur ', 13, false),
        text_span('voir plus...', 11, true)
        ],)
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
          children : [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children : [
                Text(
                  'Service à domicile',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(width : 10), // mdi_car-off.png
                at_home ? Icon(Icons.directions_car) : Image.asset(
                  "assets/images/mdi_car-off.png",
                  width: 20,
                  height: 18,
                  fit: BoxFit.contain,
                ),
              ]
            ),
            SizedBox(height : 5),
            Text(
              'Prochaine disponibilité : Demain à 15:30',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xA51ABC43),
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ]
        ),
        //BUTTON
        SizedBox(height : 10),
        Center(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return _bottomSheet(context);
                  }
              );
            },
            child: Container(
              width: 350,
              height: 35,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 16,
                        right: 24,
                        bottom: 10,
                      ),
                      child: Text(
                        'Réserver à partir de 35 €',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1, // Ajusté pour une meilleure lisibilité
                          letterSpacing: 0.10,
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height : 10),
      ]
    );
  }


  Widget _bottomSheet(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: double.infinity, // Hauteur du BottomSheet
          //height : 300,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height : 10),
              Text(
                'Options Balayage',
                style: TextStyle(
                  color: Color(0xFF1D1B20),
                  fontSize: 19,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.02,
                ),
              ),
              SizedBox(height : 20),
              Container(
                child: Text(
                  'A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made. ',
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              SizedBox(height : 20),
              Column(
                  children : [0,1,2,3].map((item){
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child : Row(
                            children : [
                              Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xF2C6DFF6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child : Center(
                                  child: Text(
                                    'A',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF21005D),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0.09,
                                      letterSpacing: 0.15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width : 20),
                              Container(
                                width : screenWidth * 0.5,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children : [
                                      Text(
                                        'Option 1',
                                        style: TextStyle(
                                          color: Color(0xFF1D1B20),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.50,
                                        ),
                                      ),

                                      Text(
                                        '15 min - 30 min',
                                        style: TextStyle(
                                          color: Color(0xFF49454F),
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                    ]
                                ),
                              ),

                              Row(
                                  children : [
                                    Text(
                                      '49,99 €',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF49454F),
                                        fontSize: 11,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0.13,
                                        letterSpacing: 0.50,
                                      ),
                                    ),

                                    Checkbox(
                                      value: true, // État actuel de la Checkbox
                                      onChanged: (bool? value) {

                                      },
                                    ),
                                  ]
                              )
                            ]
                        )
                    );
                  }).toList()
              )
            ],
          ),
        ),
        Container(
        child : Row(
            mainAxisAlignment: MainAxisAlignment.end,
          children : [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child : Text(
                  'Retour',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E5F99),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                )
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Prendre_RDV(),
                  ),
                );
              },
              child : Text(
                'Valider',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1E5F99),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              )
            )
          ]
        )
                )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final List _liste = [1,2,3,4,5,6,7,8,9,10];

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          Container(
            //color : Colors.red,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width : double.infinity,
            height : 90,
            child : ListView.builder(
              itemCount: _liste.length,
              itemBuilder: (context, index) {
                return _team('Flash', "assets/images/femme.jpg");
              },
              scrollDirection: Axis.horizontal,
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(
              'Balayages',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          Column(
            children : _liste.map((item){
              return Column(
                children : [
                  _service(context, item%2==0), SizedBox(height : 10)
                ]
              );
            }).toList()
          )
        ]
      ),
    );
  }
}
