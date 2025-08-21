class ArticleModel {
  final String status;
  final List<ArticleData> articles;

  ArticleModel({required this.status, required this.articles});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      status: json['status'],
      articles: (json['articles'] as List).map((data) {
        return ArticleData.fromJson(data);
      }).toList(),
    );
  }
}

class ArticleData {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  ArticleData({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      author: json['author'] ?? json['source']['name'],
      title: json['title'],
      description: json['description'] ?? json['content'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }
}
