import 'package:ablv2/screens/recherche_abp.dart';
import 'package:flutter/material.dart';
import '/components/annonce.dart';
import '/components/annonce_abp.dart';
import '/components/header.dart';
import '/components/tendance.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _liste = [0, 1, 2, 3, 4, 5];
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

                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coiffure Femme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(height : 10),
                      Container(
                          width: double.infinity,
                          height: 120,
                          child: ListView.builder(
                            itemCount: _liste.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Recherche_ABP(),
                                      ),
                                    );
                                  },
                                  child: Tendance(
                                    image: "assets/images/femme.jpg",
                                    label: "'Ondulations sur une ligne'",
                                    note: 4.9,
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coiffure Mixe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(height : 10),
                      Container(
                          width: double.infinity,
                          height: 120,
                          child: ListView.builder(
                            itemCount: _liste.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Recherche_ABP(),
                                      ),
                                    );
                                  },
                                  child: Tendance(
                                    image: "assets/images/femme.jpg",
                                    label: "'Ondulations sur une ligne'",
                                    note: 4.9,
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    ],
                  ),
                ),

                Center(
                  child: AnnonceAbp(),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coiffure Femme',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(height : 10),
                      Container(
                          width: double.infinity,
                          height: 120,
                          child: ListView.builder(
                            itemCount: _liste.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Recherche_ABP(),
                                      ),
                                    );
                                  },
                                  child: Tendance(
                                    image: "assets/images/femme.jpg",
                                    label: "'Ondulations sur une ligne'",
                                    note: 4.9,
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Barbe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(height : 10),
                      Container(
                          width: double.infinity,
                          height: 120,
                          child: ListView.builder(
                            itemCount: _liste.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Recherche_ABP(),
                                      ),
                                    );
                                  },
                                  child: Tendance(
                                    image: "assets/images/femme.jpg",
                                    label: "'Ondulations sur une ligne'",
                                    note: 4.9,
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
