import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controllers/navegacionmodel.dart';
import 'controllers/peticionhttp.dart';
import 'screens/newspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    //SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.dark );
    return MultiProvider(
      providers: [
        //se crea el provider para el manejo de estados entre navbar y pageview
        ChangeNotifierProvider(create: (_) => NavegacionModel()),
        //petición http
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NewsPage(),
      ),
    );
  }
}
