import 'package:flutter/material.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';

class ArticleCardWidget extends StatelessWidget {
  final ArticleData artcile;
  const ArticleCardWidget({super.key, required this.artcile});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsPalette.primaryBlackColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(artcile.urlToImage, fit: BoxFit.cover),
                  ),
                  Text(
                    artcile.description,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'View Full Article',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsPalette.primaryBlackColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(artcile.urlToImage, fit: BoxFit.cover),
            ),
            Text(
              artcile.title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By: ${shortAuthorName(artcile.author)}',
                  style: theme.textTheme.displaySmall,
                ),
                Text(
                  publishTimeConvert(artcile.publishedAt),
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String shortAuthorName(String name) {
    List<String> split = name.split(" ");
    if (split.length >= 2) {
      return "${split[0]} ${split[1]}...";
    } else if (split.length == 1) {
      return split[0];
    }

    return "";
  }

  String publishTimeConvert(String dateIso) {
    final date = DateTime.parse(dateIso);
    final now = DateTime.now().toUtc();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${(difference.inDays / 365).floor()} years ago';
    }
  }
}
