import 'package:flutter/material.dart';

import '../components/photo_institut.dart';
import '../components/ui_shared.dart';

class Recap_RDV extends StatefulWidget {
  const Recap_RDV({Key? key}) : super(key: key);

  @override
  State<Recap_RDV> createState() => _Recap_RDVState();
}

class _Recap_RDVState extends State<Recap_RDV> {

  final List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? _selectedValue;
  List _personnes = [0,1,2,3,4];

  Widget _galerie(double w, double h, String image){
    return Stack(
      children: [
        Container(
          width: w,
          height: h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Container(
          width : w,
          height : h,
          child : Center(
            child: Text(
              'Coiffure',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                height: 0,
              ),
            ),
          ),
        ),
        Positioned(
          right : 0,
          child :  Container(
            //width: 24,
            //height: 24,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.10000000149011612),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  //side: BorderSide(width: 2, color: Color(0xFFADB5BD)),
                ),
              ),
            child: IconButton(
              icon: Icon(Icons.add), // Icône du bouton
              color: Colors.white, // Couleur de l'icône
              onPressed: () {
                // Action lorsque le bouton est pressé
                print("Bouton appuyé !");
              },
              iconSize: 20.0, // Taille de l'icône
            ),
          ),
        )
      ],
    );
  }

  Widget _ligne_choix(double ecran){
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
        child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Container(
                width : ecran * 0.4,
                child : Row(
                  children: [
                    Icon(Icons.check, color : Colors.green),
                    Text(
                      'Coupe + Coiffage',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width : ecran * 0.25,
                child: Row(
                    children : [
                      Icon(Icons.favorite),
                      SizedBox(width : 5),
                      Text(
                        '30  min',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ]
                ),
              ),

              Container(
                width : ecran * 0.25,
                child: Row(
                    children : [
                      Icon(Icons.money),
                      SizedBox(width : 5),
                      Text(
                        '25 €',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ]
                ),
              )
            ]
        )
    );
  }

  Widget _personne_ligne(int item){

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children : [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.10000000149011612),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              'A',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.25),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width : 10),
            Text(
              'Moi',
              style: TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.12,
                letterSpacing: 0.50,
              ),
            ),
          ],
        ),
        Checkbox(
          value: true,
          onChanged: (bool? newValue) {
            setState(() {
              //_personnes[item] = _personnes[item] + 1;
            });
          },
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar_shared(context, 'AB Beauty Salon', '124 rue de la gare, 75 000 Paris - France'),
      body : SingleChildScrollView(
        child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            Photo_Institut(),
            SizedBox(height : 10),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                'Confirmation',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Container(
                    width: 60,
                    height: 10,
                    decoration: ShapeDecoration(
                      color: Color(0x9EFABD21),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child : Text(
                      'Dans 2 jours',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: Text.rich(
                  TextSpan(
                    children : [
                      TextSpan(
                        text: 'Prestation ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: ': ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          //height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: 'Balayage classique \n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: 'Options :',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          //height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          //height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: 'Option 1 + Option 2 + Option 3 + Option 4 \n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          //height: 0.13,
                        ),
                      ),
                      TextSpan(
                        text: 'Description : cette technique convient à presque tous les types de cheveux et est idéale pour ajouter de  ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          //height: 0.10,
                        ),
                      ),
                      TextSpan(
                        text: 'voir plus...',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          //textDecoration: TextDecoration.underline,
                          //height: 0.10,
                        ),
                      ),
                    ]
                  )
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 35,
                        height: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/team_membre.png"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom : 0,
                        right : 0,
                        child: Container(
                          width: 8.79,
                          height: 7.25,
                          decoration: ShapeDecoration(
                            color: Color(0xFF2CC069),
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFFCFCFC),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width : 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Avec \n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Nom professionnel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: ' - Nom Institut',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : [
                  Text(
                    'Rendez-vous ',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Mercredi, 24 Nov. à 15:30',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height : 10),
            //SEPARATEUR
            separateur(),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    Text(
                      'Occurrences',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    DropdownButton<String>(
                      hint: Text('Sélectionner une option'), // Texte de l'indication
                      value: _selectedValue, // La valeur sélectionnée actuelle
                      icon: Icon(Icons.arrow_drop_down), // Icône du menu déroulant
                      items: _options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue; // Mise à jour de la valeur sélectionnée
                        });
                      },
                    )
                  ]
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Choix d’expérience\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        //height: 0.04,
                      ),
                    ),
                    TextSpan(
                      text: '\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        //height: 0.04,
                      ),
                    ),
                    TextSpan(
                      text: 'Choisissez un image qui représenter la prestation de votre choix ou crée votre expérience unique avec vos photos préférées à l’aider d’intelligence artificielle. ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        //height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: 'En savoir plus ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        //textDecoration: TextDecoration.underline,
                        //height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: '...\n',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        //height: 0.10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width : screenWidth,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child : Row(
                children : [
                  _galerie(130, 175, "assets/images/cheveux.png"),
                  SizedBox(width : 10),
                  Column(
                   children : [
                     Row(
                       children : [
                         _galerie(130, 85, "assets/images/cheveux.png"),
                         SizedBox(width : 5),
                         _galerie(100, 85, "assets/images/cheveux.png"),
                       ]
                     ),
                     SizedBox(height : 5),
                     Row(
                         children : [
                           _galerie(130, 85, "assets/images/cheveux.png"),
                           SizedBox(width : 5),
                           _galerie(100, 85, "assets/images/cheveux.png"),
                         ]
                     )
                   ]
                  )
                ]
              )
            ),

            Column(
              children : [0,1,2,3].map((item){
                return _ligne_choix(screenWidth);
              }).toList()
            ),

            Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child : Text(
                'Identification',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              )
            ),

            //TELEPHONE OU MAIL
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : [
                  Text(
                    'Téléphone ou Mail* ',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),

                  Container(
                    width: 236,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child : TextField(
                      decoration: InputDecoration(
                        hintText: 'mon.indentification@mail.com',
                        border: InputBorder.none, // Pas de bordure par défaut
                        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 0),
                      ),
                      style : TextStyle(
                        color: Colors.black.withOpacity(0.8500000238418579),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ),
                ]
              ),
            ),

            //MOT DE PASSE
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    Text(
                      'Mot de passe * ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6000000238418579),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),

                    Container(
                      width: 236,
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.10000000149011612),
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child : TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '*********************',
                          border: InputBorder.none, // Pas de bordure par défaut
                          contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: 0),
                        ),
                        style : TextStyle(
                          color: Colors.black.withOpacity(0.8500000238418579),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      )
                    ),
                  ]
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  ElevatedButton(
                    onPressed: () {  },
                    child: Text("Inscription"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black.withOpacity(0.5),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0), // Coins arrondis
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {  },
                    child: Text("Se connecter"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0), // Coins arrondis
                      ),
                    ),
                  ),
                ]
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Text(
                'Pour qui ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.04,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              child : Column(
                children: _personnes.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;

                  return Column(
                    children: [
                      _personne_ligne(index),   // Affiche l'index de chaque élément
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              )
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 0, 15, 10),
              child : Row(
                children : [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child : Center(child: Icon(Icons.person_add))
                  ),
                  SizedBox(width : 10),
                  Text(
                    'Nouvelle personne',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: 0.50,
                    ),
                  ),
                ]
              )
            ),

            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
              child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  Text(
                    'Paiement',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height : 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children : [
                      Text(
                        'Code promotion & Carte cadeau',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.05000000074505806),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child : TextField(
                          decoration: InputDecoration(
                            hintText: 'AB224-xXXx-XB',
                            border: InputBorder.none, // Pas de bordure par défaut
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      )
                    ]
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    width : screenWidth,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                      children : [
                        Text(
                          '- 50 € de réduction',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xF7F12C12),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Prix total : ',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6000000238418579),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: '135 €',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        )
                      ]
                    ),
                  ),

                  //PAIEMENT EN LIGNE
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children : [
                      Text(
                        'Paiement en ligne',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      Checkbox(
                        value: true,
                        onChanged: (bool? newValue) {
                          setState(() {
                            //_personnes[item] = _personnes[item] + 1;
                          });
                        },
                      )
                    ]
                  ),

                  //PAIEMENT SUR PLACE
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        Text(
                          'Paiement sur place',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Checkbox(
                          value: false,
                          onChanged: (bool? newValue) {
                            setState(() {
                              //_personnes[item] = _personnes[item] + 1;
                            });
                          },
                        )
                      ]
                  ),

                  //PAIEMENT EN PLUSIEURS FOIS
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        Text(
                          'Paiement en plusieurs fois',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Checkbox(
                          value: false,
                          onChanged: (bool? newValue) {
                            setState(() {
                              //_personnes[item] = _personnes[item] + 1;
                            });
                          },
                        )
                      ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
