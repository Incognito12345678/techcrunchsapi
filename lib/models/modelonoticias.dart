// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

//con este modelo se obtiene la informacion de la api
//de noticias y se guarda en una lista
//para poder ser mostrada en la pantalla de noticias
import 'dart:convert';

//recibe un string y regresa una instancia de newservice con todos sus
//atributos
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));
//welcomeFromJson convierte el json en un objeto de tipo Welcome

//este seria usado para un posteo o post
String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  int totalResults;
  List<Article> articles;

  Welcome({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        //author: json["author"] == null ? null : json["author"],
        author: json["author"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? '',
        //urlToImage: json["urlToImage"] ?? null,
        //urlToImage: json["urlToImage"] as String ?? "",
        urlToImage: json["urlToImage"] ?? '',
        //json['urlToImage'] as String? ??
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        //"author": author == null ? null : author,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,

        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        //id: json["id"] == null ? null : json["id"],
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        //"id": id == null ? null : id,
        "id": id,
        "name": name,
      };
}
//cbau discord
//De hecho está bien así ya que el valor es dinámico, 
//e incluso el ?? null está de más, ya que de 
//cualquier forma el valor por defecto es nulo. 
//Ya si quieres especificar el valor, puedes hacer algo 
//tipo json[urlToImage'] as String?, y el valor no acepta nulos,
// puedes darle un valor distinto a nulo así: json['urlToImage'] as String? ?? '' 
