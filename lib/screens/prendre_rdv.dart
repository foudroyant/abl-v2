import 'package:flutter/material.dart';

import '../components/indisponible.dart';
import '../components/photo_institut.dart';
import '../components/ui_shared.dart';
import '../models/creneau.dart';
import '../models/prestation.dart';
import '../utils/fn_global.dart';

class Prendre_RDV extends StatefulWidget {
  final Prestation service;
  const Prendre_RDV({Key? key, required this.service}) : super(key: key);

  @override
  State<Prendre_RDV> createState() => _Prendre_RDVState();
}

class _Prendre_RDVState extends State<Prendre_RDV> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final List _liste = [null,1,2,3,4,5,6];


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
                itemCount: _liste.length,
                itemBuilder: (context, index) {
                  bool _isConnected = index%2 == 0;
                  return index != 0 ? Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/team_membre.png"),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height : 10),
                            Container(
                              child : Text(
                                'Salsabila',
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
                return Indisponible(day: item, service: widget.service, options: [],);
              }).toList()
            )
          ]
        )
      )
    );
  }
}
