import 'package:apinoticias/controllers/peticionhttp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/listadonoticias.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //se crea la instancia de la peticion
    //y se llama a la lista de noticias(headlines)
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        //si la lista de noticias esta vacia se muestra un circulo de carga
        //si no se muestra la lista de noticias
        body: //(headlines.length == 0)
            (headlines.isEmpty)
                //if
                ? const Center(child: CircularProgressIndicator())
                //else
                //se pasa la lista de noticias a la clase ListaNoticias
                : ListaNoticias(headlines));

    /*if ((headlines.length == 0)
            const Center(child: CircularProgressIndicator())
        else
            ListaNoticias(headlines)
            );*/
  }

  @override
  bool get wantKeepAlive => true;
}
