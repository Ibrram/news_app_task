import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_task/api/contstants.dart';
import 'package:news_app_task/api/end_points.dart';
import 'package:news_app_task/core/enums/news_api_enum.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/models/source_model.dart';

abstract class Requests {
  static Future<SourceModel?> getSources(String category) async {
    Map<String, dynamic> parms = {
      "category": category,
      "apiKey": Contstants.apiKey,
    };
    var data = await http.get(
      Uri.https(Contstants.domain, EndPoints.sources, parms),
    );

    if (data.statusCode == 200) {
      return SourceModel.fromJson(jsonDecode(data.body));
    }

    return null;
  }

  static Future<ArticleModel?> getArticles(String source) async {
    Map<String, dynamic> parms = {
      "apiKey": Contstants.apiKey,
      "sources": source,
    };
    var data = await http.get(
      Uri.https(Contstants.domain, EndPoints.articles, parms),
    );

    if (data.statusCode != 200) return null;
    var decodedData = jsonDecode(data.body);
    if (decodedData['status'] == NewsApiEnum.ok.name) {
      return ArticleModel.fromJson(decodedData);
    }
    return null;
  }
}
