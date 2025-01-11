import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/indisponible.dart';
import '../../components/photo_institut.dart';
import '../../components/ui_shared.dart';
import '../../models/creneau.dart';
import '../../models/institut.dart';
import '../../models/prestation.dart';
import '../../utils/fn_global.dart';
import 'models.dart';

class Prendre_RDV extends StatefulWidget {
  final Prestation service;
  final Institut institut;
  const Prendre_RDV({Key? key, required this.service, required this.institut}) : super(key: key);

  @override
  State<Prendre_RDV> createState() => _Prendre_RDVState();
}

class _Prendre_RDVState extends State<Prendre_RDV> {

  List<Team> team = [
    Team(nom: 'Admin', prenom: 'System', image: 'https://img.freepik.com/free-vector/default-avatar.jpg', user: 'admin_system', online: true)
  ];
  Team selected_membre = Team(nom: 'Admin', prenom: 'System', image: 'https://img.freepik.com/free-vector/default-avatar.jpg', user: 'admin_system', online: true);
  List<Creneau> indisponibles = [];

  Future<List<Team>> fetchTeams(String institutId) async {
    try {
      // Référence à la sous-collection `team` d'un institut
      CollectionReference teamCollection = FirebaseFirestore.instance
          .collection('instituts')
          .doc(institutId)
          .collection('team');

      // Récupérer les documents de la sous-collection
      QuerySnapshot querySnapshot = await teamCollection.get();

      // Convertir les documents en objets Team
      List<Team> teams = querySnapshot.docs.map((doc) {
        return Team.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      print(teams);
      setState((){
        team = [team[0],...teams];
      });

      return teams;
    } catch (e) {
      print('Erreur lors de la récupération des équipes : $e');
      return [];
    }
  }

  void fetchCreneaux() async {
    try {
      // Référence à la sous-collection `creneaux_indisponibles` d'un institut
      CollectionReference teamCollection = FirebaseFirestore.instance
          .collection('instituts')
          .doc(widget.institut.id)
          .collection('creneaux_indisponibles');

      // Récupérer les documents de la sous-collection
      QuerySnapshot querySnapshot = await teamCollection.get();

      // Convertir les documents en objets Team
      List<Creneau> _creneaux = querySnapshot.docs.map((doc) {
        //print(doc.data());
        return Creneau.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      //print(_creneaux);
      setState((){
        indisponibles = _creneaux;
      });

    } catch (e) {
      print('Erreur lors de la récupération des creneaux : $e');
    }
  }

  @override
  initState() {
    fetchTeams(widget.institut.id);
    fetchCreneaux();
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
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Equipes ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height : 10),
            Container(
              width : screenWidth,
              height : 70,
              child : ListView.builder(
                itemCount: team.length,
                itemBuilder: (context, index) {
                  final _t = team[index];
                  bool _isConnected = _t.online;
                  return index != 0 ? Stack(
                    children: [
                      InkWell(
                        onTap : (){
                          setState((){
                            selected_membre = _t;
                          });
                      },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            children: [
                        
                              Container(
                                width: 50,
                                height: 50,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey, // Couleur de fond par défaut si l'image ne se charge pas
                                ),
                                child: Image.network(
                                  _t.image, // URL de l'image
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // Image déjà chargée
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                        
                              SizedBox(height : 10),
                              Container(
                                child : Text(
                                  '${_t.nom}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0F1828),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.11,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom : 20,
                        right : 0,
                        child : Container(
                          width: 12,
                          height: 12,
                          decoration: ShapeDecoration(
                            color: _isConnected ? Color(0xFF2CC069) : Color(0xFFD9D9D9), // NON CONNECTE Color(0xFFD9D9D9)
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFFFCFCFC),
                              ),
                            ),
                          ),
                        )
                      )
                    ],
                  ) : Column(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF7F7FC),
                            image: DecorationImage(
                              image: AssetImage("assets/images/plus.png"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: Color(0xFFADB5BD)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ),
                      SizedBox(height : 10),
                      Text(
                        'Indiffèrent',
                        style: TextStyle(
                          color: Color(0xFF0F1828),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.11,
                        ),
                      ),
                    ],
                  );
                },
                scrollDirection: Axis.horizontal,
              )
            ),
            Column(
              children : getWeekDates(DateTime.now()).map((item){
                //print(indisponibles);
                return Indisponible(
                  day: item,
                    service: widget.service,
                    options: [],
                    institut: widget.institut,
                    indisponibles: indisponibles.where((i)=>i.membres.contains(selected_membre.user)).toList(),
                  membre: selected_membre,
                );
              }).toList()
            )
          ]
        )
      )
    );
  }
}
