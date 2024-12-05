import 'package:ablv2/screens/recherche_abp.dart';
import 'package:ablv2/screens/resultats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/tendance.dart';
import '../models/tendances.dart';
import '/components/annonce.dart';
import '/components/annonce_abp.dart';
import '/components/header.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _liste = [0, 1, 2, 3, 4, 5];
  final db = FirebaseFirestore.instance;
  List<Tendance_Model> tendances = [];
  List<String> categories = [];




  List<Tendance_Model> getByCategorie(String cat){
    return tendances.where((t){
      return t.categorie == cat;
    }).toList();
  }

  // Initialisation dans initState()
  @override
  void initState() {
    super.initState();
    db.collection("tendances").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          setState((){
            tendances.add(Tendance_Model(
              id: docSnapshot.id,
              nom : docSnapshot.data()['nom'],
              image : docSnapshot.data()['image'],
              categorie : docSnapshot.data()['categorie'],
              note : docSnapshot.data()['note'],
            ));
            categories.add(docSnapshot.data()['categorie']);
          });
          //print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    setState((){
      categories.toSet().toList();
    });

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(is_home: true),
                SizedBox(
                  height: 10,
                ),
                Annonce(),
                SizedBox(
                  height: 10,
                ),

                //Les boutons horizontals
                Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: double.infinity,
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: null,
                          child: Text(
                            'Coiffure',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )),

                //TENDANCE PAR CATEGORIES
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text(
                    'Tendance par catégories',
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
                  children : categories.toSet().toList().map((cat){
                    return Column(
                        //crossAxisAlignment : CrossAxisAlignment.center,
                      children : [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cat,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width: double.infinity,
                                  height: 120,
                                  child: ListView.builder(
                                    itemCount: getByCategorie(cat).length,
                                    itemBuilder: (context, index) {
                                      Tendance_Model item = getByCategorie(cat)[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Resultats(input: item.nom),
                                              ),
                                            );
                                          },
                                          child: Tendance(
                                            image: "assets/images/femme.jpg",
                                            label: item.nom,
                                            note: item.note,
                                          ),
                                        ),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                  )),
                            ],
                          ),
                        ),
                            Row(
                                mainAxisAlignment : MainAxisAlignment.center,
                              children : [
                                Container(
                                  child : ["Arts & Loisirs"].contains(cat) ? Center(child: AnnonceAbp()) : null,
                                )
                              ]
                            )
              ]
                    );

                  }).toList()
                ),

              ],
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
