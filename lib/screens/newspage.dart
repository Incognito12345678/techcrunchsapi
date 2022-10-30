import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/navegacionmodel.dart';
import 'Tab1page.dart';
import 'Tab2page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Paginas(),
        ),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

//bottomNavigationBar
class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Business',
        ),
      ],
      //el valor donde se ubica es = a paginaActual
      currentIndex: navegacionModel.paginaActual,
      //cuando se presiona un item se
      //cambia el valor de paginaActual
      onTap: (i) => navegacionModel.paginaActual = i,

      selectedItemColor: Colors.amber[800],
    );
  }
}

class Paginas extends StatelessWidget {
  const Paginas({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<NavegacionModel>(context);
    //pageview para cambiar de pagina,
    //similar a lo que hicimos
    //con el bottomNavigationBar
    return PageView(
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        //Tab2Page()
      ],
    );
  }
}
