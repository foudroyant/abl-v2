import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  bool is_home;
  Search({super.key, required this.is_home});
  @override
  Widget build(BuildContext context) {
    double largeur = 360;
    double hauteur = 40;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : [
            Container(
                width: largeur,
                height: hauteur,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.10000000149011612),
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    is_home ? Icon(Icons.menu) : InkWell(child: Icon(Icons.arrow_back), onTap: () {
                      Navigator.pop(context); // Retour à la page précédente
                    },),
                    Container(
                      width: largeur - 100,
                      height: hauteur,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Salon, prestation (coupe...)',
                          border: InputBorder.none, // Pas de bordure par défaut
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        ),
                        style : TextStyle(
                          color: Colors.black.withOpacity(0.8500000238418579),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                )
            ),
          ]
      ),
    );
  }
}
