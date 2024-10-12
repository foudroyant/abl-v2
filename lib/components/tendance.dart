import 'package:flutter/material.dart';

class Tendance extends StatelessWidget {
  final String label;
  final String image;
  final double note;

  Tendance({required this.label, required this.image, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 105,
          height: 105,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 106,
                  height: 105,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 106,
                  height: 90,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 45.57,
                  height: 18.99,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/star_orange.png"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        note.toString(),
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
              ),
              Positioned(
                left: 83,
                top: 76,
                child: Container(
                  width: 16,
                  height: 16,
                  padding: const EdgeInsets.all(0),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC67C4E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        child: Icon(Icons.add, size: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 91,
                child: SizedBox(
                  width: 106,
                  height: 12,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9B9B9B),
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
