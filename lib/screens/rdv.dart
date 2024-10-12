import 'package:flutter/material.dart';


class RDV extends StatefulWidget {
  const RDV({Key? key}) : super(key: key);

  @override
  State<RDV> createState() => _RDVState();
}

class _RDVState extends State<RDV> {

  Widget _book(double ecran, bool futur){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children : [
          Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            //width: 358,
            height: 29,
            decoration: ShapeDecoration(
              color: futur ? Color(0x44FABD21) : Color(0x4445A74F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
            child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : [
                Row(
                  children : [
                    Icon(Icons.book),
                    SizedBox(width : 10),
                    Text(
                      'Mercredi 24 Novembre',
                      textAlign: TextAlign.center,
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

                Row(
                  children : [
                    Icon(Icons.access_alarm_rounded),
                    SizedBox(width : 5),
                    Text(
                      '15:24',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ]
                )
              ]
            )
          ),
          SizedBox(height : 10),
          Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
            child: Row(
              children : [
                Container(
                  width: 60,
                  height: 30,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rec_book.png"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                SizedBox(width : 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    Text(
                      'AB Beauty Salon',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Row(
                      children : [
                        Icon(Icons.book, size : 13),
                        SizedBox(width : 5),
                        Text(
                          '24 rue de la gare, 75000 Paris',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ]
                    )
                  ]
                )
              ]
            ),
          ),
          SizedBox(height : 10),
          Container(
            padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
            child: Text(
              'Prestations :',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          SizedBox(height : 10),
          Column(
            children : [0,1,2].map((item){
              return _ligne_choix(ecran);
            }).toList()
          ),
          futur ? _params_book_futur(ecran) : _params_book_past(ecran)
        ]
      ),
    );
  }

  Widget _ligne_choix(double ecran){
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    mainAxisAlignment: MainAxisAlignment.end,
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

  Widget _params_book_past(double ecran){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return _bottomSheet_avis(context);
                    }
                );
              },
              child: Text("Laissez votre avis",
                style: TextStyle(
                  //fontSize: 10,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w700,
                ),),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF1D5F98),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {  },
              child: Text("Reprendre RDV",
                style: TextStyle(
                  //fontSize: 10,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w700,
                ),),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF0F72C9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0), // Coins arrondis
                ),
              ),
            ),
          ]
      )
    );
  }

  Widget _params_book_futur(double ecran){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children : [
          Row(
            children : [
              Container(
                width : ecran * 0.70,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Prendre rendez-vous plus tôt ?\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Recevez une alerte si un rendez-vous se libère avant le votre.',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ]
          ),
          SizedBox(height : 10),
          Row(
            children : [
              Container(
                width : ecran * 0.70,
                child : Text(
                  'Ajouter à mon agenda',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            ]
          ),
          SizedBox(height : 10),
          Row(
              children : [
                Container(
                  width : ecran * 0.70,
                  child : Text(
                    'Ajouter une alerte',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )
              ]
          ),
          SizedBox(height : 15),

          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              ElevatedButton(
                onPressed: () {  },
                child: Text("Annuler ou déplacer le RDV",
                  style: TextStyle(
                    //fontSize: 10,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w700,
                  ),),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF1D5F98),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {  },
                child: Text("Contacter PRO",
                  style: TextStyle(
                    //fontSize: 10,
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w700,
                  ),),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF0F72C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Coins arrondis
                  ),
                ),
              ),
            ]
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child : Scaffold(
        appBar : AppBar(
          title: Text(
            'Réservations',
            style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.white, // Couleur de fond de l'indicateur
              borderRadius: BorderRadius.circular(7), // Bordures arrondies
              border: Border.all(
                color: Color(0xFFE5E5EA), // Couleur de la bordure
                width: 0.50, // Épaisseur de la bordure
              ),
            ),
            tabs: [
              Tab(
                child: Center(child: Text("A venir")),
              ),
              Tab(
                child: Center(child: Text("Passés")),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _book(screenWidth, true),
            _book(screenWidth, false),
          ],
        ),
      )
    );
  }

  Widget _bottomSheet_avis(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
        child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Center(
                child: Text(
                  'Votre avis compte !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height : 10),
              Row(
                  children : [
                    Text(
                      'Accueil',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ]
              ),

              SizedBox(height : 10),
              Text(
                'Commentaire',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(height : 10),
              Container(
                width : screenWidth * 0.6,
                child: Text(
                  'Votre commentaire compte et aidera les utilisateurs à faire le bon choix !',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height : 10),
              Container(
                width: screenWidth,
                height: 117,
                decoration: BoxDecoration(color: Color(0x230F72C9)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'En laissant votre avis, vous acceptez qu’il soit publié.',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height : 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {  },
                  child: Text("Valider",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF34C759),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100), // Coins arrondis
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }
}
