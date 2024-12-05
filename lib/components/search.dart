import 'package:flutter/material.dart';

import '../screens/recherche_abp.dart';

class Search extends StatefulWidget {
  final bool is_home;

  Search({super.key, required this.is_home});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  late FocusNode _focusNode;
  bool _hasFocus = false;
  TextEditingController? controller = TextEditingController();

  void _removeFocus() {
    _focusNode.unfocus(); // Retirer le focus
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    if(widget.is_home == false){
      setState((){
        _focusNode.unfocus();
      });
    }

    //focusNode: _focusNode,

    // Ajoute un listener pour surveiller le focus
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        if(widget.is_home == true && _hasFocus == true){
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Recherche_ABP(),
            ),
          );*/
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller?.dispose(); // Libération du TextEditingController// Nettoie le FocusNode pour éviter les fuites de mémoire
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double largeur = 360;
    double hauteur = 40;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.is_home
                    ? Icon(Icons.menu)
                    : InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {

                          if(widget.is_home == false){
                            setState((){
                              _focusNode.unfocus();
                            });
                          }
                          Navigator.pop(context); // Retour à la page précédente
                        },
                ),
                Container(
                  width: largeur - 100,
                  height: hauteur,
                  child: TextField(
                    controller : controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Salon, prestation (coupe...)',
                      border: InputBorder.none, // Pas de bordure par défaut
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    ),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8500000238418579),
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                    onSubmitted: (value) {
                      if(widget.is_home == true){
                      print(controller?.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Recherche_ABP(input: controller!.text,),
                          ),
                        );
                      }// Gérer le submit lors de l'appui sur Entrée
                    },
                  ),
                ),
                InkWell(
                  onTap : (){
                    if(widget.is_home == true){
                      print(controller?.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recherche_ABP(input: controller!.text),
                        ),
                      );
                    }
                  },
                    child: Icon(Icons.search)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
