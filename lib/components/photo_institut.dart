import 'package:flutter/material.dart';


class Photo_Institut extends StatelessWidget {
  const Photo_Institut({Key? key}) : super(key: key);

  Widget _photo(String photo, double w, double h){
    return Container(
      width: w,
      height: h,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: AssetImage(photo),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width : screenWidth,
      child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children : [
            _photo("assets/images/institut.png", (screenWidth/2) - 10, 250 ),
            Container(
              height : 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children : [
                  _photo("assets/images/institut.png", (screenWidth/2) - 10 , 115 ),
                  Container(
                    width : (screenWidth/2) - 10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children : [
                        _photo("assets/images/institut.png", (screenWidth/4) - 10 , 115 ),
                        Container(
                          height : 115,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children : [
                                _photo("assets/images/institut.png", (screenWidth/4) - 15 , 50 ),
                                _photo("assets/images/institut.png", (screenWidth/4) - 15 , 50 ),
                              ]
                          ),
                        )
                      ]
                    ),
                  )
                ]
              ),
            )
          ]
      )
    );
  }
}
