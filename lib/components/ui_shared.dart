import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


PreferredSize appBar_shared(BuildContext context, String institut_label, String institut_localisation){
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0), // Hauteur personnalisée
    child: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back), // Bouton retour
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
          children: [
            Text(
              institut_label,
              style: appBarTextStyle,
            ),
            Text(
              institut_localisation,
              style: appBarText2Style,
            ),
          ],
        ),
      ),
      backgroundColor: appBarColor,
      actions: [
        IconButton(
          icon: Icon(Icons.share), // Icône de tri
          onPressed: () {
            print("Icône de tri cliquée");
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite), // Icône de filtre
          onPressed: () {
            print("Icône de filtre cliquée");
          },
        ),
      ],
    ),
  );
}

Widget separateur(){
  return Center(
    child: Container(
      //padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: 360,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.black.withOpacity(0.05000000074505806),
          ),
        ),
      ),
    ),
  );
}