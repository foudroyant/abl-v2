import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/photo_institut.dart';
import '../../components/ui_shared.dart';
import '../../models/creneau.dart';
import '../../models/institut.dart';
import '../../models/prestation.dart';
import '../../models/user.dart';
import '../../utils/fn_global.dart';
import 'add_person.dart';
import 'models.dart';

class Recap_RDV extends StatefulWidget {
  final Institut institut;
  final Prestation prestation;
  final List<Option> options;
  final DateTime jour;
  final Creneau creneau;
  const Recap_RDV({Key? key, required this.institut, required this.prestation, required this.options, required this.jour, required this.creneau}) : super(key: key);

  @override
  State<Recap_RDV> createState() => _Recap_RDVState();
}

class _Recap_RDVState extends State<Recap_RDV> {

  final List<String> occurences = [
    "Aucune",
    "Tous les mois",
    "Tous les semaines"
  ];
  String? occurence_selected;
  int index_personne = 0;
  int index_payement = 0;
  int nbre_de_jours = 0;


  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _telephoneController = TextEditingController();

  final _promoCtrl = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User_Model user_model;
  List<Person> personnes = [];

  List<Map> experiences = [
    {
      "exp": Prestation_Exp(
          label: 'Experience 1',
          temps: '45min',
          prix: 80,
          image: 'https://cdn.pixabay.com/photo/2020/04/30/03/58/john-tyler-5111297_960_720.png'
      ),
      "selected": false
    },
    {
      "exp": Prestation_Exp(
          label: 'Exp 2',
          temps: '60min',
          prix: 50,
          image: 'https://cdn.pixabay.com/photo/2013/07/12/18/42/john-f-kennedy-153721_960_720.png'
      ),
      "selected": false
    },
    {
      "exp": Prestation_Exp(
          label: 'Exp 3',
          temps: '40min',
          prix: 300,
          image: 'https://cdn.pixabay.com/photo/2020/05/23/12/34/girl-5209390_1280.jpg'
      ),
      "selected": false
    },
    {
      "exp": Prestation_Exp(
          label: 'Exp 4',
          temps: '30min',
          prix: 150,
          image: 'https://cdn.pixabay.com/photo/2017/08/01/11/48/woman-2564660_1280.jpg'
      ),
      "selected": false
    },
    {
      "exp": Prestation_Exp(
          label: 'Exp 5',
          temps: '20min',
          prix: 30,
          image: 'https://cdn.pixabay.com/photo/2020/10/17/17/41/girl-5662873_1280.jpg'
      ),
      "selected": false
    },
  ];



  // Variable pour afficher les erreurs
  String? _errorMessage;

  List<Promotion> check_promo(String code){
    return widget.institut.promotions.where((p) => p.code == code).toList();
  }

  Future<void> updatePersonnes(String userId, List<Map<String, dynamic>> newPersonnes) async {
    try {
      // Référence à la collection Firestore "users"
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Mise à jour de la clé "personnes"
      await users.doc(userId).update({'personnes': newPersonnes});

    } catch (e) {
      print("Erreur lors de la mise à jour de 'personnes' : $e");
    }
  }

  getUserById(String userId) async {
    try {
      // Accéder au document dans la collection "users"
      DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (document.exists) {
        final _user = document.data() as Map<String, dynamic>; // Retourne les données sous forme de Map
        User_Model _user_model = User_Model.fromMap(_user);
        /*setState((){
          user_model = User_Model.fromMap(_user);
          user_model.add_person(Person(
            nom: "Moi",
            telephone: user!.phoneNumber!,
          ));
        });*/

        List<Person> _personnes = _user_model.personnes;
        setState((){
          personnes = _personnes;
        });
      } else {}

    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'utilisateur: $e");
    }
  }

  @override
  initState() {
    Duration difference = widget.jour.difference(DateTime.now());
    setState((){
      nbre_de_jours = (difference.inHours / 24).round() ;
    });
    getUserById(user!.uid);

    //print(widget.prestation.toMap());
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }


  Widget _galerie(double w, double h, Map exp, int index){
    Prestation_Exp prestation = exp["exp"];
    return prestation != null ? Stack(
      children: [
        Container(
          width: w,
          height: h,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: NetworkImage(prestation.image),
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
          color : experiences[index]["selected"] == true ? Color.fromRGBO(0, 0, 0, 0.5) : Color.fromRGBO(0, 0, 0, 0),
          child : Center(
            child: Text(
              prestation.label,
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
            child: InkWell(
              onTap : (){
                setState((){
                  experiences[index]["selected"] = !experiences[index]["selected"];
                });
              },
                child: Icon(Icons.add)
            ),
          ),
        )
      ],
    ) : Container();
  }

  Widget _ligne_choix(Map experience, double ecran){

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
                      experience["exp"].label,
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
                        experience["exp"].temps,
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
                        '${experience["exp"].prix} €',
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

  Widget _personne_ligne(Person item, int index){

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
              item.nom,
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
          value: index == index_personne,
          onChanged: (bool? newValue) {
            setState(() {
              if(newValue == true){
                setState((){
                  index_personne = index;
                });
              }
              else {
                setState((){
                  //index_personne = index;
                });
              }

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
                      'Dans ${nbre_de_jours} jours',
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
                        text: '${widget.prestation.nom} \n',
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
                      widget.options.length > 0 ? TextSpan(
                        text: 'Option 1 + Option 2 + Option 3 + Option 4 \n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          //height: 0.13,
                        ),
                      ) : TextSpan(),
                      TextSpan(
                        text: 'Description : ${widget.prestation.description} ',
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
                          text: ' - ${widget.institut.nom}',
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
                    '${formaterDate(widget.jour)}, à ${widget.creneau.creneau.hour}:${widget.creneau.creneau.minute}',
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
                      value: occurence_selected, // La valeur sélectionnée actuelle
                      icon: Icon(Icons.arrow_drop_down), // Icône du menu déroulant
                      items: occurences.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          occurence_selected = newValue; // Mise à jour de la valeur sélectionnée
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
                  _galerie(130, 175, experiences[0], 0),
                  SizedBox(width : 10),
                  Column(
                   children : [
                     Row(
                       children : [
                         _galerie(130, 85, experiences[1], 1),
                         SizedBox(width : 5),
                         _galerie(100, 85, experiences[2], 2),
                       ]
                     ),
                     SizedBox(height : 5),
                     Row(
                         children : [
                           _galerie(130, 85, experiences[3], 3),
                           SizedBox(width : 5),
                           _galerie(100, 85, experiences[4], 4),
                         ]
                     )
                   ]
                  )
                ]
              )
            ),

            Column(
              children : experiences.where((e)=>e["selected"] == true).map((item){
                return _ligne_choix(item,screenWidth);
              }).toList()
            ),

            FirebaseAuth.instance.currentUser != null ? Container(
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
            ) : Container(),

            FirebaseAuth.instance.currentUser != null ? Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              child : Column(
                children: personnes.reversed.toList().asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;

                  return Column(
                    children: [
                      _personne_ligne(item, index),   // Affiche l'index de chaque élément
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              )
            ) : Container(),
            FirebaseAuth.instance.currentUser != null ?  InkWell(
              onTap : (){
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ajouter_personne(),
                      ),
                    );
                  },
                );
              },
              child: Container(
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
            ) : Container(),

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
                          controller : _promoCtrl,
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
                        _promoCtrl.text.isNotEmpty &&  check_promo(_promoCtrl.text).length > 0 ? Text(
                          '- 50 € de réduction',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xF7F12C12),
                            fontSize: 13,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ) : Container(),
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
                                text: '${widget.prestation.prix} €',
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
                        value: index_payement == 0,
                        onChanged: (bool? newValue) {
                          setState(() {
                            //_personnes[item] = _personnes[item] + 1;
                            if(newValue == true) index_payement = 0;
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
                          value: index_payement == 1,
                          onChanged: (bool? newValue) {
                            setState(() {
                              if(newValue == true) index_payement = 1;
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
                          value: index_payement == 2,
                          onChanged: (bool? newValue) {
                            setState(() {
                              if(newValue == true) index_payement = 2;
                            });
                          },
                        )
                      ]
                  )
                ]
              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap : (){
                  /*print("Personne : ${personnes[index_personne].toMap()} *** Methode de payement ${index_payement} *** "
                      "Occurence : ${occurence_selected}");*/
                  List<Map> presta_exp = experiences.where((e)=>e["selected"] == true)
                  .map((e){
                    return Prestation_Exp.fromMap(e["exp"].toMap()).toMap();
                  }).toList();

                  /*final _reservation = Reservation(
                    institut: widget.institut.toPublicInfo(),
                    date: widget.jour,
                    alerte: false,
                    addToAgenda: false,
                    notifierAvant: false,
                    notifierTantDeTemps: 0,
                    userInfo: User_Info.fromMap({
                      'displayName': user?.displayName,
                      'telephone': user?.phoneNumber,
                      'email': user?.email,
                      'uid': user?.uid,
                    }),
                    prestations: presta_exp,
                    creneau: widget.creneau,
                    personne: personnes[index_personne],
                    occurrence: occurence_selected!,
                  );*/

                  final Map _reservation = {
                    'institut': widget.institut.toPublicInfo().toMap(),
                    'date': widget.jour,
                    'alerte': false,
                    'addToAgenda': false,
                    'notifierAvant': false,
                    'notifierTantDeTemps': 0,
                    'userInfo': {
                      'displayName': user?.displayName == null ? "Moi" : user?.displayName,
                      'telephone': user?.phoneNumber,
                      'email': user?.email,
                      'uid': user?.uid,
                    },
                    'prestations': presta_exp,
                    'creneau': widget.creneau.toMap(),
                    'personne': personnes[index_personne].toMap(),
                    'occurrence': occurence_selected == null ? "Aucune" : occurence_selected!,
                  };

                  print(_reservation);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 354,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: Color(0xC429C90F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    ),
                    child : Center(
                      child: Text(
                        'Valider',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }

  Widget ajouter_personne() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ajouter une personne',
              //style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _prenomController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un prénom';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _telephoneController,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un numéro de téléphone';
                }
                // Vous pouvez ajouter une validation plus poussée pour le numéro de téléphone ici
                return null;
              },
            ),
            SizedBox(height: 24),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {

                  setState((){
                    personnes.add(Person(nom: '${_prenomController.text} ${_nomController.text}', telephone: _telephoneController.text));
                  });
                  final _personnes = personnes.map((p){
                    return p.toMap();
                  }).toList();

                  updatePersonnes(user!.uid!, _personnes);
                  _formKey.currentState?.reset();
                  // Fermer le BottomSheet
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: 354,
                height: 35,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
                child : Center(
                  child: Text(
                    'Valider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
