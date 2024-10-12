import 'package:ablv2/components/star.dart';
import 'package:flutter/material.dart';


class Item_Search extends StatelessWidget {

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children : [
        Container(
          width: 80,
          height: 80,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/femme.jpg'),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        Container(
          width : screenWidth * 0.6,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children : [
                  Text(
                    'Synergy Salon',
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.10,
                    ),
                  ),
                  //LES ETOILES
                  Row(
                    children : [
                      ReviewStar(),ReviewStar(),ReviewStar(),ReviewStar(),ReviewStar(),
                    ]
                  ),

                ]
              ),
              SizedBox(height : 20),
              Container(
                width: 214,
                child: Text(
                  'Category • \$\$ • 1.2 miles away  ',
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              SizedBox(height : 15),
              Container(
                width: 220,
                child: Text(
                  truncateText('Supporting line text lorem ipsum dolor sit amet, consectetur.', 30),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xFF49454F),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ]
          ),
        ),
        Container(
          width: 24,
          height: 64,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/coeur.png'),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        )
      ]
    );
  }
}