import 'dart:async';

import 'package:flutter/material.dart';

// class du widget
class AdsWidget extends StatefulWidget {
  AdsWidget({super.key});

  /*
    dart:
      List : équivalent à un array indicé
      Map : équivalent à un objet  JS   (clé - valeure)
 
    visibilité des membres :
      pas de visibilité protected
      quand il a une propriété préfixé de _ ceci veut dire qu'elle est protected (ex _maPropriéte)
  */

  // Liste des Map
  final List<Map> _items = [
    {'img': 'ad1.jpg', 'text': 'Ordinateur et tablettes '},
    {'img': 'ad2.jpg', 'text': 'Iphone 12 mini jusqu-a -30%'},
    {'img': 'ad3.jpg', 'text': 'Ecran TV '},
  ];

  // idnice
  int _index = 0;

  // minuteur
  // ? : valeur nulle
  Timer? _timer;

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

// class de l'état du widget qui hérite de la class du Widget    , methode build responsable pour l'affichage
class _AdsWidgetState extends State<AdsWidget> {
  /*
    cycle de vie d'un widget
      initState : affichage du widget
      dispose : désaffichage du widget
  */
  @override
  void initState() {
    super.initState();
    //declencher le timer
    widget._timer = Timer.periodic(const Duration(seconds: 2), _setTimer);
  }

  void _setTimer(Timer timer) {
    // setState : permet de modifier uné tat et de décencher la mise à jour visuelle du widget
    setState(() {
      if (widget._index < widget._items.length - 1) {
        widget._index++;
      } else {
        widget._index = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //stopper le minuteur
    // null coaslesing : utilisation ?
    // ! : permet de définir que la valeur n'est pas nulle
    widget._timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // le mot_clé widget permet d'accéder à la classe du wiget à partir de la classe de l'état du widget
        Image.asset('assets/img/${widget._items[widget._index]['img']}'),
        Text(widget._items[widget._index]['text']),
      ],
    );
  }
}
