import 'package:ablv2/screens/resultats.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';
import '../components/item_search.dart';

class Recherche_ABP extends StatefulWidget {
  final String input;
  const Recherche_ABP({Key? key, required this.input}) : super(key: key);

  @override
  State<Recherche_ABP> createState() => _Recherche_ABPState();
}

class _Recherche_ABPState extends State<Recherche_ABP> {
  String input = "";

  Widget _displayZone(String title, double width){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
      width : width,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0.09,
                letterSpacing: 0.50,
              ),
            ),
            SizedBox(height : 15),
            Column(
              children : [1,2,3,4].map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical : 5),
                  child: InkWell(
                      child: Item_Search(),
                    onTap : (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resultats(input: input,),
                        ),
                      );
                    }
                  ),
                );
              }).toList()
            )
          ]
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    print(widget.input);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body : SafeArea(
          child : SingleChildScrollView(
              child : Container(
                color : Colors.white,
                //padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      Header(is_home: false),
                      SizedBox(height : 10),
                      _displayZone('Recommandations', screenWidth),
                      SizedBox(height : 10),
                      _displayZone('Historiques', screenWidth),
                      SizedBox(height : 10),
                      _displayZone('Les mieux notés', screenWidth)
                    ]
                ),
              )
          )
      )
    );
  }
}
