class SourceModel {
  final String status;
  final List<SourceData> sources;

  SourceModel({required this.status, required this.sources});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      status: json['status'],
      sources: (json['sources'] as List).map((e) {
        return SourceData.fromJson(e);
      }).toList(),
    );
  }
}

class SourceData {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  SourceData({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory SourceData.fromJson(Map<String, dynamic> json) {
    return SourceData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}
