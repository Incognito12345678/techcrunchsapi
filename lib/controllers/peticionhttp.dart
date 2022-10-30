// ignore_for_file: unnecessary_this, prefer_const_declarations, non_constant_identifier_names

import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/category.dart';
import '../models/modelonoticias.dart';

// ignore: non_constant_identifier
final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '8929eaaf79cd4ed9b52e992fcf2277b5';

//https://newsapi.org/v2/top-headlines?country=us&apiKey=8929eaaf79cd4ed9b52e992fcf2277b5
//modelo provider
class NewsService with ChangeNotifier {
  //encabezados
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  //lista de categorias horizontal de la segunda pantalla
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    // ignore: deprecated_member_use
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  //aqui es similar a la primera peticion donde se guarda la data en headlines.
  Map<String, List<Article>> categoryArticles = {};

  //constructor
  NewsService() {
    //metodo que hace la peticion
    getTopHeadlines();

    //segunda peticion
    categories.forEach((item) {
      this.categoryArticles[item.name] = List.empty();
    });
    for (var item in categories) {
      // ignore: deprecated_member_use
      //categoryArticles[item.name] = List.empty();
      categoryArticles[item.name] = [];
    }

    this.getArticlesByCategory(this._selectedCategory);
  }
  //se hace la peticion 1
  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
    final resp = await http.get(Uri.parse(url));

    //se obtiene la respuesta y se guarda
    //serializacion
    final newsResponse = welcomeFromJson(resp.body);
    //newsResponse devuelve un objeto de tipo Welcome

    //se guarda la lista de noticias en la variable headlines

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  //esto hace parte de la segunda pantalla o peticion
  bool get isLoading => this._isLoading;

  String get selectedCategory => this._selectedCategory;
  //get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  //segunda pantalla o peticion
  //List<Article>? get getArticulosCategoriaSeleccionada =>
  //  this.categoryArticles[this.selectedCategory];

  //primer lectura de la segunda peticion
  //y esto devuelve una lista de articulos
  List<Article> get getArticulosCategoriaSeleccionada {
    return this.categoryArticles[this.selectedCategory]!;
  }

  //aqui empieza la segunda peticion, se consiguen articulos por categoria
  getArticlesByCategory(String category) async {
    /*if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }*/
    if (this.categoryArticles[category]!.isNotEmpty) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url =
        //debo acceder a esta url para comprenderlo
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = welcomeFromJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
