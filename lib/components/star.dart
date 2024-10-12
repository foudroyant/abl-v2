import 'package:flutter/material.dart';

class ReviewStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Review_star.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}