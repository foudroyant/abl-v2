import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/photo_institut.dart';
import '../components/ui_shared.dart';
import '../models/creneau.dart';
import '../models/institut.dart';
import '../models/prestation.dart';
import '../models/user.dart';
import '../utils/fn_global.dart';

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

  final List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? _selectedValue;
  int index_personne = 0;
  int index_payement = 0;
  int nbre_de_jours = 0;

  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Variable pour afficher les erreurs
  String? _errorMessage;


  @override
  initState(){
    Duration difference = widget.jour.difference(DateTime.now());
    setState((){
      nbre_de_jours = (difference.inHours / 24).round() ;
    });
  }


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
              print(newValue);
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

  // Méthode pour se connecter
  Future<void> _login() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Si la connexion réussit, naviguez vers l'écran d'accueil
      if (userCredential.user != null) {
        emailController.text = "";
        passwordController.text = "";
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur de connexion : ${e.toString()}";
      });
    }
  }

  Future<void> registerUser(
      String email, String password,
      String nom,
      String telephone,
      BuildContext context
      ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Ajouter les informations de l'utilisateur dans Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'displayName': nom,
        'email': email,
        'phoneNumber' : telephone,
        'createdAt': FieldValue.serverTimestamp(),
        'personnes' : [
          {
            'nom' : nom,
            'telephone' : telephone
          }
        ]
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Utilisateur créé : ${userCredential.user?.email}")),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = "Le mot de passe est trop faible.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "L'email est déjà utilisé.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "L'adresse e-mail est invalide.";
      } else {
        errorMessage = "Une erreur est survenue : ${e.message}";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Déconnecté avec succès")),
      );
      // Rediriger vers l'écran de connexion ou une autre page
      Navigator.pushReplacementNamed(context, '/login'); // Exemple : '/login'
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la déconnexion : $e")),
      );
    }
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

            FirebaseAuth.instance.currentUser == null ? Container(
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
            ) : Container(),

            //TELEPHONE OU MAIL
            FirebaseAuth.instance.currentUser == null ? Container(
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'mon.indentification@mail.com',
                        border: InputBorder.none, // Pas de bordure par défaut
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      ),
                      style : TextStyle(
                        color: Colors.black.withOpacity(0.8500000238418579),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ),
                ]
              ),
            ) : Container(),

            //MOT DE PASSE
            FirebaseAuth.instance.currentUser == null ? Container(
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
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.10000000149011612),
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child : TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '*********************',
                          border: InputBorder.none, // Pas de bordure par défaut
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        ),
                        style : TextStyle(
                          color: Colors.black.withOpacity(0.8500000238418579),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ]
              ),
            ) : Container(),

            FirebaseAuth.instance.currentUser == null ? Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  ElevatedButton(
                    onPressed: () async {
                      await registerUser(
                          emailController.text,
                          passwordController.text,
                          'Utilisateur Client',
                          '+242 00 000 11 22',
                          context,
                      );

                      setState((){

                      });
                    },
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
                    onPressed: () {
                      onPressed: _login;
                    },
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
            ) : Container(),

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
                children: context.read<User_Provider>().user.personnes.asMap().entries.map((entry) {
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
                logoutUser(context);
                setState((){

                });
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

            FirebaseAuth.instance.currentUser != null ?Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 354,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: Color(0xC429C90F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  child : Text(
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
            ) : Container(),
          ]
        )
      )
    );
  }
}
