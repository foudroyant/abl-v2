import 'package:flutter/material.dart';

class AvisNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 15,
          //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.1599999964237213),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 15,
                height: 15,
                child: Image.asset(
                  "assets/images/star_orange.png",
                  //width: 20,
                  //height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              //const SizedBox(width: 2),
              Text(
                '4.9',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}