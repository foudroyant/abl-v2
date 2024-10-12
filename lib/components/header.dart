import 'package:ablv2/components/search.dart';
import 'package:flutter/material.dart';
import '/utils/colors.dart';
import '/utils/styles.dart';

class Header extends StatelessWidget {
  bool is_home;
  Header({required this.is_home});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 225,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.87, -0.49),
              end: Alignment(0.87, 0.49),
              colors: [primaryColor, primaryColor],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/LogoABL.png",
                  width: 60,
                  height: 35,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 15,
                ),
                const Text(
                  'Réservez \nune expérience de beauté',
                  style: sora_title,
                ),
                const SizedBox(
                  height: 20,
                ),
                Search(is_home: is_home)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
