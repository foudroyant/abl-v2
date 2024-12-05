import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/institut.dart';
import '../models/prestation.dart';
import '../screens/prendre_rdv.dart';

class Presentation extends StatefulWidget {
  final Institut institut;
  const Presentation({Key? key, required this.institut}) : super(key: key);

  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {

  List<Prestation> prestations = [];


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

  Widget _service(BuildContext context, Prestation prestation){
    return Column(
      children : [
        Text.rich(
        TextSpan(
        children: [
          text_span('${prestation.nom}\n', 16, false),
        text_span('\n', 16, false),
        text_span(prestation.description, 13, false),
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
                prestation.a_domicile ? Icon(Icons.directions_car) : Image.asset(
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
              if(prestation.options.length > 0){
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return _bottomSheet(context, prestation);
                    }
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Prendre_RDV(service: prestation,),
                  ),
                );
              }
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
                        'Réserver à partir de ${prestation.prix} €',
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


  Widget _bottomSheet(BuildContext context, Prestation prestation){
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
                    builder: (context) => Prendre_RDV(service: prestation,),
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

  void get_services(){
    FirebaseFirestore.instance.collection("instituts").doc(widget.institut.id).collection("services").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          //print('${docSnapshot.id} => ${docSnapshot.data()}');
          setState((){
            prestations.add(Prestation(
                id: docSnapshot.id,
                nom: docSnapshot.data()["nom"],
                description: docSnapshot.data()["description"],
                a_domicile: docSnapshot.data()["a_domicile"],
                prix: docSnapshot.data()["prix"],
                duree: docSnapshot.data()["duree"],
                categorie: docSnapshot.data()["categorie"],
                type: docSnapshot.data()["type"]
            ));
          });
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    super.initState();
    get_services();
  }

  @override
  Widget build(BuildContext context) {

    final List _liste = [0,1,2,3];
    //final List _liste = widget.institut.categories.split(",").toSet().toList();
    final List _categories = widget.institut.les_categories();


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
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _team(_categories[index],"assets/images/femme.jpg");
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
            children : prestations.map((item){
              return Column(
                children : [
                  _service(context, item), SizedBox(height : 10)
                ]
              );
            }).toList()
          )
        ]
      ),
    );
  }
}
