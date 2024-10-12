import 'package:flutter/material.dart';

class AnnonceAbp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 362,
        height: 126,
        decoration: ShapeDecoration(
          color: Color(0xFF0F4F88),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.white.withOpacity(0.699999988079071),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Vous êtes Professionnel ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Améliorer votre confort de travail avec ABP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //backgroundColor: Colors.white,
                //foregroundColor: Color(0xFF1D5F98),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: null,
              child: Text(
                'Télécharger ABL PRO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  //color: Color(0xFF1D5F98),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.10,
                  letterSpacing: 0.10,
                ),
              ),
            )
          ],
        ));
  }
}
