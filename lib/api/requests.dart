import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_task/api/contstants.dart';
import 'package:news_app_task/api/end_points.dart';
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
}
