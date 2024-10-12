import 'package:flutter/material.dart';

class Annonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 360,
          height: 66,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFEAE7E7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.96, -0.27),
                end: Alignment(0.96, 0.27),
                colors: [Color(0xFF027EA5), Color(0xFF5E5E5E)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/images/Vector.png",
                    width: 60,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                          'Invitez des amis et obtenez \nune réduction de -10% chacun.\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 5,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Doublez la joie !',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
