import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  PageController _pageController = PageController();

  //devuelve el valor actual de _paginaActual 0 o 1
  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
